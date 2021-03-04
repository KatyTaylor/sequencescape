# The first plate created from the stock plate during library preparation
# Used by:
#
# - ILB_STD_COVARIS (No longer used)
# - Shear (No longer used)
# - ILC AL Libs (No longer used)
# - PF Shear
#
# Triggers library start when the plate is started
#
# This behaviour is probably redundant now, as this is handled by the transfer requests.
#
# @todo #2396 Confirm removal does not affect Limber 'High Throughput PCR Free 96' pipeline, then remove.
#      - Update any purposes using this class by running `bundle exec rake remove:deprecated_purposes`
#         Ensure that this class is listed in the reported output before removing this file. You should also be safe to remove this class
#         from  lib/tasks/remove_deprecated_purposes.rake
#       - Update:
#           app/models/illumina_b/plate_purposes.rb
#           app/models/illumina_c/plate_purposes.rb
#           app/models/illumina_htp/plate_purposes.rb
#         By either replacing with PlatePurpose, or removing the factories entirely
class PlatePurpose::InitialPurpose < PlatePurpose
  self.state_changer = StateChanger::InitialPlate
end
