# frozen_string_literal: true

module Heron
  module Factories
    module Concerns
      #
      # This module adds validation and tools to manage factories that act as content in a receptacle
      # Eg: ::Heron::Factories::Sample
      #
      # **Requirements**
      # - The method or attribute content_factory needs to be defined with the class that act as 
      #   factory for contents. Eg: ::Heron::Factories::Sample
      # - The content configuration should be already stored in @params
      # - The content configuration object needs to be in @params[recipients_key]
      # - The method or attribute recipients_key will need to identify the key where the config is
      #   stored. Eg: :wells
      # - All keys in the content configuration are considered as validated, if that is not the case,
      #   that validation can be provided by including the module Heron::Factories::Concerns::RecipientsCoordinate
      # - The class should include the module Heron::Factories:Concerns::CoordinatesSupport
      #
      # **Use**
      # Include the module in the class after checking the previous list of requirements. 
      #
      # **Effect**
      # Factories for each content in each well will be generated.
      # Any validation error from them will be aggregated in the base object.
      #
      # **Examples of params**
      # 1. Empty contents
      # {}
      # 
      # 2. A well at position A1, with a sample that has name 'Sample 1'
      # { wells: {'A1': {content: {name: 'Sample 1', sample_uuid: <uuid>} } } }
      # 
      # 3. Two aliquots in position B1 from samples with name 'Sample 1' and 'Sample 2'
      #    and both will be created under study <uuid>
      # { wells: {'B1': {content: [{name: 'Sample 1'}, {name: 'Sample 2'}] } }, sample_uuid: <uuid>}
      module Contents
        def self.included(klass)
          klass.instance_eval do
            validate :contents
          end
        end

        def study_uuid
          @params[:study_uuid]
        end

        def contents
          return if errors.count.positive?
          return unless params_for_contents

          @contents ||= params_for_contents.keys.each_with_object({}) do |coordinate, memo|
            samples_params = [params_for_contents[coordinate]].flatten.compact
            memo[unpad_coordinate(coordinate)] = _factories_for_location(coordinate, samples_params)
          end
        end

        # Creates aliquots for the samples that will be created from contents.
        # Args:
        # containers_for_locations: Hash<Coordinate, Container> where container is a Well or a tube and Coordinate
        # is a position in the rack
        # Returns:
        # Boolean indicating if the action was produced        
        def add_aliquots_into_locations(containers_for_locations)
          return unless contents

          contents.each do |location, factories|
            container = containers_for_locations[location]
            factories.each do |factory|
              factory.create_aliquot_at(container) if factory.valid?
            end
          end
          true
        end

        def params_for_contents
          return unless @params[recipients_key]

          @params_for_contents ||= @params[recipients_key].keys.each_with_object({}) do |location, obj|
            obj[unpad_coordinate(location)] = @params.dig(recipients_key, location, :content)
          end
        end

        def _factories_for_location(location, samples_params)
          samples_params.each_with_index.map do |sample_params, pos|
            label = samples_params.length == 1 ? "Content #{location}" : "Content #{location}, pos: #{pos}"
            sample_params = sample_params.merge(study_uuid: study_uuid) if study_uuid
            factory = content_factory.new(sample_params)
            errors.add(label, factory.errors.full_messages) unless factory.valid?
            factory
          end
        end
      end
    end
  end
end
