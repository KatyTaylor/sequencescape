require 'rails_helper'

RSpec.describe 'Bug research' do
  context 'GPL-207' do
    context %Q{
       Incorrect submission ids recorded in transfer requests when other plates with
      the same samples have library requests under different submission ids still in progress
    } do

      def create_pool_requests(plate, pool_defs, pool_instances, submission_ids)
        pool_defs.each_with_index do |well_locs, index|
          plate.wells.located_at(well_locs).each do |well|
            create(:re_isc_request,
                   asset: well,
                   target_asset: nil,
                   pre_capture_pool: pool_instances[index],
                   submission_id: submission_ids[index])
          end
        end
      end

      def create_cherrypick_requests(plate, target_plate, transfers, submission_id)
        transfers.map do |source,destinations|
          target_plate.wells.located_at(destinations).map do |destination|
            create(:cherrypick_request,
              asset: plate.wells.located_at(source).first,
              target_asset: destination,
              submission_id: submission_id)
          end
        end.flatten
      end

      context %Q{
        We have a Stock plate with 9 samples, from it, we create 2 new plates (plates 1 and 2) and we
        cherrypick the wells from the Stock plate into the plates 1 and 2 going A1=> A1, B1=> B1, etc...
        We perform this cherypick by creating a cherrypick request between Stock plate and LB PCR xp plates

        These cherrypick requests will create a transfer request between the wells, all the requests belonging
        to the same submission id.
        } do
        let(:stock_plate_purpose) { create :stock_plate_purpose }
        let(:stock_plate) {
          create :plate, :with_wells, sample_count: 9, plate_purpose: stock_plate_purpose,
            well_factory: :tagged_well
        }
        let(:pcr_xp_purpose) { create :plate_purpose, name: 'LB Lib PCR-XP' }
        let(:pcr_xp_plate1) { create :plate, :with_wells, sample_count: 9, plate_purpose: pcr_xp_purpose }
        let(:pcr_xp_plate2) { create :plate, :with_wells, sample_count: 9, plate_purpose: pcr_xp_purpose }
        let(:stamp_transfers) {
          pcr_xp_plate1.wells.each_with_object({}) do |w, hash|
            hash[w.map_description] = w.map_description
          end
        }
        let(:submission_A) { 1 }
        let(:submission_B) { 2 }
        before do
          # We create a cherrypick request for each well at stock plate to the 2 destinations plates Lib PCR-XP
          # this will also create the transfer requests
          create_cherrypick_requests(stock_plate, pcr_xp_plate1, stamp_transfers, submission_A)
          create_cherrypick_requests(stock_plate, pcr_xp_plate2, stamp_transfers, submission_B)
        end

        it 'will create the transfer requests under the submission id of the corresponding cherrypick request' do
          expect(
            pcr_xp_plate1.wells.map(&:transfer_requests_as_target).flatten.map(&:submission_id).uniq
          ).to eq([submission_A])
          expect(
            pcr_xp_plate2.wells.map(&:transfer_requests_as_target).flatten.map(&:submission_id).uniq
          ).to eq([submission_B])
        end

        context 'when I create a LB Lib Prepool plate' do
          let(:prepool_purpose) { create :plate_purpose, name: 'LB Lib Prepool' }
          let(:prepool_plate) {
            create :plate, :with_wells, sample_count: 9, plate_purpose: prepool_purpose
          }

          context 'when I create 1 Repooling ISC request for each well in the Lib PCR-XP plate' do
            let(:pool_instances1) { create_list :pre_capture_pool, 3 }
            let(:submission_C) { 4 }
            let(:submission_D) { 5 }
            let(:submission_E) { 6 }
            let(:pool_transfer1) {
              {
                "A1" => ["A1"],
                "B1" => ["A1"],
                "C1" => ["A1"],
                "D1" => ["B1"],
                "E1" => ["B1"],
                "F1" => ["B1"],
                "G1" => ["C1"],
                "H1" => ["C1"],
                "A2" => ["C1"],
              }
            }
            let(:pooling_definition1) {
              [
                ["A1", "B1","C1"],
                ["D1", "E1","F1"],
                ["G1", "H1","A2"]
              ]
            }
            before do
              # We create the pool requests from the first Lib PCR-XP plate into the new empty Lb Lib Prepool
              # getting wells in groups of 3 and setting submission 4,5 and 6 for the pools (at A1, B1, C1)
              create_pool_requests(pcr_xp_plate1, pooling_definition1, pool_instances1, [submission_C,submission_D,submission_E])
            end
            it 'will create the transfer requests using the submissions ids from the Repooling requests' do
              # Now we create the transfer requests that represent the pool from before
              create :transfer_between_plates, transfers: pool_transfer1, source: pcr_xp_plate1,
                destination: prepool_plate

              # The new transfer requests should have the submission id from the pooling requests (4,5,6), not 1
              s_ids = prepool_plate.wells.map(&:transfer_requests_as_target).flatten.map{|r| r.submission_id}
              expect(s_ids.uniq).to eq([submission_C,submission_D,submission_E])
            end
            context 'when I create another Repooling ISC request for each well in the Lib PCR-XP plate' do
              context 'when the new pooling has a different transfers definition' do
                let(:submission_F) { 7 }
                let(:submission_G) { 8 }
                let(:pool_instances2) { create_list :pre_capture_pool, 2 }
                let(:pool_transfer2) {
                  {
                    "A1" => ["A1"],
                    "B1" => ["A1"],
                    "C1" => ["A1"],
                    "D1" => ["A1"],
                    "E1" => ["B1"],
                    "F1" => ["B1"],
                    "G1" => ["B1"],
                    "H1" => ["B1"],
                    "A2" => ["B1"],
                  }
                }
                let(:pooling_definition2) {
                  [
                    ["A1", "B1","C1", "D1"],
                    ["E1","F1", "G1", "H1","A2"]
                  ]
                }
                before do
                  # Now we create another repooling
                  create_pool_requests(pcr_xp_plate1, pooling_definition2, pool_instances2, [submission_F,submission_G])
                end

                it 'creates the transfer with the right submission id' do
                  create :transfer_between_plates, transfers: pool_transfer2, source: pcr_xp_plate1,
                    destination: prepool_plate

                  s_ids = prepool_plate.wells.map(&:transfer_requests_as_target).flatten.map{|r| r.submission_id}
                  expect(s_ids.uniq).to eq([submission_F,submission_G])
                end
              end
              context 'when the new pooling has the same transfers definition' do
                let(:submission_H) { 9 }
                let(:submission_I) { 10 }
                let(:submission_J) { 11 }
                let(:pool_instances3) { create_list :pre_capture_pool, 3 }
                let(:pool_transfer3) {
                  {
                    "A1" => ["A1"],
                    "B1" => ["A1"],
                    "C1" => ["A1"],
                    "D1" => ["B1"],
                    "E1" => ["B1"],
                    "F1" => ["B1"],
                    "G1" => ["C1"],
                    "H1" => ["C1"],
                    "A2" => ["C1"],
                  }
                }
                let(:pooling_definition3) {
                  [
                    ["A1", "B1","C1"],
                    ["D1", "E1","F1"],
                    ["G1", "H1","A2"]
                  ]
                }
                before do
                  # Now we create another repooling
                  create_pool_requests(pcr_xp_plate1, pooling_definition3, pool_instances3, [submission_H,submission_I,submission_J])
                end

                it 'raises an error when creating the transfer because it does not know which one is the right submission id' do
                  # There are 2 pools with equal configuration, so it does not know which pooling requests we are
                  # referring to when creating the transfer requests.
                  create :transfer_between_plates, transfers: pool_transfer3, source: pcr_xp_plate1,
                    destination: prepool_plate

                  expect{
                    create :transfer_between_plates, transfers: pool_transfer3, source: pcr_xp_plate1,
                      destination: prepool_plate
                  }.to raise_error
                end
              end
            end
          end
        end
      end
    end
  end
end
