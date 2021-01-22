# frozen_string_literal: true

# Controls authorization (the ability to do something) based on the current user
# and driven mostly by assigned roles.
# @note API V1 abilities predate this file and are managed separately in {Core::Abilities}
# Powered by CanCanCan https://rdoc.info/github/CanCanCommunity/cancancan
class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    Rails.logger.debug { "Auth: #{user}, roles: #{user.try(:roles)&.map(&:name)}" }
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    # JG: While these don't *have* to correspond to controller actions, it
    #     is easier to handle if they do. (Where appropriate of course)
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    # Privileges granted even if you aren't
    # logged in.
    grant_global_privileges

    # Only grant basic privileges if the user isn't logged in
    # See {AuthenticatedSystem lib/authenticated_system} for current_user
    # handling.
    # @note I haven't worked out why we use a symbol here, rather than false.
    # rubocop:disable Lint/BooleanSymbol
    return if user.nil? || user == :false

    # rubocop:enable Lint/BooleanSymbol

    # Privileges granted to any logged in users
    grant_basic_privileges

    # Eager load roles to avoid lots of queries
    user.roles.load

    # TODO
    # These actions have been extracted from the existing role driven permission system

    # LabwareController:182
    # Can rename labware (admin)
    # Can change plate purpose (admin, lab_manager)
    grant_administrator_privileges if user.administrator?
    grant_lab_manager_privileges if user.lab_manager?
    grant_manager_privileges if user.manager? # Can easily get this role by creating a project
    grant_sample_management_privileges if user.slf_manager? || user.slf_gel?
    grant_slf_manager_privileges if user.slf_manager?
    grant_qa_privileges if user.qa_manager?
  end

  # Global privileges are those granted
  # EVEN IF THE USER IS NOT LOGGED IN
  def grant_global_privileges; end

  # Permissions granted to all users following
  # authentication
  def grant_basic_privileges
    can %i[update release accession], Sample, owners: { id: user.id }
    can %i[read update], User, { id: user.id }
    can %i[projects study_reports], User
    can :delete, Comment, { user_id: user.id }
    # There isn't really much reason to stop users seeing this
    can :read, Delayed::Job
    can :read, ReferenceGenome
    can :read, [TagGroup, TagLayoutTemplate]
    can :read, Robot
    # Basic users can only create submissions using projects they own.
    can :create_submission, Project, owners: { id: user.id }
    can :print_asset_group_labels, Study, owners: { id: user.id }
    can :print_asset_group_labels, Study, managers: { id: user.id }
    can %i[read create], Submission
    can :create, Comment, commentable_type: %w[Study Sample], commentable: { owners: { id: user.id } }
    grant_advanced_batch_operation_privileges
  end

  def grant_administrator_privileges
    # Labware
    can :rename, Labware
    can :change_purpose, Labware

    # Requests
    can :update, Request
    # Lets the user request additional sequencing/libraries
    # under a different study/project than the original
    can :edit_additional, Request
    # For old pipelines, removes QC events
    can :reset_qc_information, Request

    # If a sample has been released to the ENA, we need
    # to be careful about releasing it.
    can :update_released, Sample

    # Administer covers update of the studies via the
    # admin/studies controller. It mostly adds the ability
    # to activate/deactivate a study and change ethical approval
    # or data-release fields
    can :administer, Study
    # If the user is an administrator show all studies.
    can :request_additional_with, Study
    can :unlink_sample, Study
    can :link_sample, Study
    can :accession, Study
    can %i[grant_role remove_role], Study

    # Projects
    # Administer covers update of the projects via the
    # admin/projects controller. It mostly adds the ability
    # to disable enforced validation, and add financial approval
    can :administer, Project
    # Manage is actually more powerful than administer.
    can :manage, Project

    can :rollback, Batch

    can :delete, Comment

    can :manage, BarcodePrinter
    can :create, [Purpose, PlatePurpose]
    can :manage, Program
    can :manage, [BaitLibrary, BaitLibrary::Supplier, BaitLibraryType]
    can :manage, PrimerPanel

    can :manage, Role
    can :delete, Document

    can :manage, AssetGroup
    can :create, Order

    can :print_asset_group_labels, Study
    # Edit and delete submissions
    can :manage, Submission

    grant_power_user_privileges
    grant_super_user_privileges
    grant_sample_management_privileges
    grant_tag_privileges
  end

  # Grants the ability to create tag_groups
  def grant_tag_privileges
    can :manage, TagGroup
    can :manage, TagLayoutTemplate
  end

  def grant_lab_privileges
    can :print_asset_group_labels, Study
  end

  def grant_lab_manager_privileges
    can :manage, Labware
    can :change_purpose, Labware
    can :change_priority, [Request, Submission]
    can :update_priority, [Pipeline] # Really should be on request
    # Whether the inbox shows if a request is previously failed
    can :see_previously_failed, Request
    grant_lab_privileges
  end

  # Mainly granted to SSRs because they manage studies
  # Really this role should *NOT* contain generic permissions
  # only those associated with specific studies
  def grant_manager_privileges
    # Can update and edit projects they manage
    can :update, Project, managers: { id: user.id }
    # If a user is a manager, this is the list of studies
    # shown in the dropdown.
    can :request_additional_with, Study, managers: { id: user.id }
    # Slight changes to behaviour, selects most permissive route
    can :unlink_sample, Study, managers: { id: user.id }
    can :accession, Study, managers: { id: user.id }
    can :link_sample, Study, managers: { id: user.id }

    # Includes ability to add labware to asset group
    can :create, AssetGroup, study: { managers: { id: user.id } }
    can :create, Order, study: { managers: { id: user.id } }

    grant_power_user_privileges
    grant_sample_management_privileges
  end

  # These are the privileges shared by administrators and managers
  def grant_power_user_privileges
    # Admin link will appear
    can :administer, Sequencescape
    can :manage, Labware
    can :manage, PlateTemplate
    can :close, Receptacle
    can :manage, Receptacle
    can :cancel, Request
    can :copy, Request
    can :change_decision, Request
    can :create_additional, Request
    can :update, Sample
    can :release, Sample
    can :accession, Sample
    can %i[activate deactivate], Study
    can :update, Study
    can :create, SampleManifest
    can :create, Supplier
    can :create, Comment
    # Slight difference here from before. Previously managers
    # could use any study/project until they were owner,
    # manager or follows of a project, as which point they were
    # limited to that one.
    can :create_submission, Project
  end

  # Contains the privileges which should really be
  # restricted to a small subset of users. Currently
  # awarded to all admins.
  def grant_super_user_privileges
    # More advanced user administration, such as the ability to add
    # and remove roles
    can :manage, User
    # Changing help text
    can :manage, CustomText
    # Can edit existing plate purposes
    can :manage, [Purpose, PlatePurpose]
    can :manage, [Robot, RobotProperty]
    can :manage, FacultySponsor
    can :manage, ReferenceGenome
    can :manage, Role
    can :convert_to_tube, Plate
    can %i[activate deactivate], Pipeline
  end

  def grant_sample_management_privileges
    # Index page of a few sample management tasks
    can :read, SampleLogisticsController
    # Old gels controller.
    can :manage, GelsController
  end

  def grant_slf_manager_privileges
    can :create, SampleManifest
    can :create, Supplier
    can :manage, PlateTemplate
    can :convert_to_tube, Plate
  end

  def grant_qa_privileges
    can :create, QcDecision
  end

  # Before this was granted to anyone, unless they
  # were an owner of anything, in which case they also
  # had to be a manager, possibly of something
  # This is silly. So we'll just grant them to everyone
  # now, but pop them in a separate section so its easy to
  # revisit
  def grant_advanced_batch_operation_privileges
    can :create_stock_asset, Batch
    can :sample_prep_worksheet, Batch
    can :print, Batch
    can :verify, Batch
    can :edit, Batch
  end
end
