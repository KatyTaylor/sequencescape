require_dependency 'tube/purpose'

# {Tube::Purpose} for standard {MultiplexedLibraryTube multiplexed library tubes}.
# Used in the legacy {Pipeline pipelines} and in non-pipeline processes such as
# {Pooling}. Represents one or more tagged libraries in a tube together, suitable
# for Sequencing.
# @note As of 201-10-01 only used for 'Standard MX' and 'Tag MX' tubes (Gatekeeper)
class Tube::StandardMx < Tube::Purpose
  self.state_changer = StateChanger::StandardMxTube
end
