class SangerSampleId < ApplicationRecord # rubocop:todo Style/Documentation
  class Factory # rubocop:todo Style/Documentation
    def self.instance
      @instance ||= new
    end

    def next!
      SangerSampleId.create!.sample_id
    end
  end

  alias sample_id id

  class << self
    def generate_sanger_sample_id!(study_abbreviation, sanger_id = nil)
      "#{study_abbreviation}#{sanger_id || SangerSampleId::Factory.instance.next!}"
    end
  end
end
