# frozen_string_literal: true

# Privileges granted to users with the lab_manager role
class Ability::QaManager
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    grant_privileges
  end

  private

  def grant_privileges
    Rails.logger.debug { 'Granting QaManager privileges' }
    can :create, QcDecision
  end
end
