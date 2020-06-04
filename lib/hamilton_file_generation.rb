module Sanger
  module Robots
    module Hamilton
      #
      # Generates the picking file contents for the Hamilton robot
      #
      class Generator
        class << self
          include ::CommonFileGenerator

          # Formats values in the data object into output rows for the file
          def mapping(data_object)
            raise ArgumentError, 'Data object not present for Hamilton mapping' if data_object.nil?

            output_file_contents = [column_headers]
            output_file_contents << source_mappings(data_object)
            output_file_contents.join("\n").gsub(/\n\n/, "\n")
          end

          private

          # sets number of decimal places on volumes, robot has a precision limit when aspirating/dispensing
          def hamilton_precision_value(value)
            value.to_f.round(configatron.hamilton_precision)
          end

          # sorts the rows by destination well
          def each_mapping(data_object)
            data_object['destination'].each do |dest_plate_barcode, plate_details|
              mapping_by_well = Hash.new { |h, i| h[i] = [] }
              plate_details['mapping'].each do |mapping|
                destination_position = Map::Coordinate.description_to_vertical_plate_position(mapping['dst_well'], plate_details['plate_size'])
                mapping_by_well[destination_position] << mapping
              end

              mapping_by_well.sort_by { |a| a[0] }.each do |_dest_position, mappings|
                mappings.each do |mapping|
                  yield(mapping, dest_plate_barcode, plate_details)
                end
              end
            end
          end

          def column_headers
            'SourcePlateID,SourceWellID,SourcePlateType,SourcePlateVolume,DestinationPlateID,DestinationWellID,DestinationPlateType,DestinationPlateVolume,WaterVolume'
          end

          # formats the data object into rows to output in the file
          def source_mappings(data_object)
            source_mappings = ''
            each_mapping(data_object) do |mapping, destination_plate_barcode, plate_details|
              source_plate_barcode = (mapping['src_well'][0]).to_s
              source_well_position = mapping['src_well'][1]
              source_plate_type = data_object['source'][(mapping['src_well'][0]).to_s]['name']
              destination_well_position = mapping['dst_well']
              destination_plate_type = plate_details['name']
              current_row = [
                source_plate_barcode,
                source_well_position,
                source_plate_type,
                hamilton_precision_value(mapping['volume']).to_s,
                destination_plate_barcode,
                destination_well_position,
                destination_plate_type,
                hamilton_precision_value(mapping['volume']).to_s,
                hamilton_precision_value(mapping['buffer_volume']).to_s
              ].join(',')
              source_mappings += "#{current_row}\n"
            end
            source_mappings
          end
        end
      end
    end
  end
end
