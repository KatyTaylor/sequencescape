# frozen_string_literal: true

# require 'rails_helper'
require 'spec_helper'

RSpec.describe StateChanger::InitialStockTube do
  let(:state_changer) do
    described_class.new(
      labware: labware,
      target_state: target_state,
      user: user,
      customer_accepts_responsibility: customer_accepts_responsibility
    )
  end

  let(:user) { create :user }
  let(:customer_accepts_responsibility) { false }
  let(:labware) { create :tube }
  let(:submission) { create :submission }
  let(:well) { create :well }
  let!(:transfer_request) do
    create :transfer_request, asset: well, target_asset: labware.receptacle,
                              state: transfer_request_state, outer_request: request
  end
  let!(:request) { create :customer_request, asset: well, state: request_state, submission: submission }

  before do
    well.stock_wells << well
    state_changer.update_labware_state
  end

  context 'when the tube is: "pending"' do
    let(:transfer_request_state) { 'pending' }

    context 'when transitioning to "started" with "pending" requests' do
      let(:target_state) { 'started' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "started" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('started')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "started" with "started" requests' do
      let(:target_state) { 'started' }
      let(:request_state) { 'started' }

      it 'updates the tube to "started" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('started')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "started" with "failed" requests' do
      let(:target_state) { 'started' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "started" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('started')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "started" with "passed" requests' do
      let(:target_state) { 'started' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "started" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('started')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "started" with "cancelled" requests' do
      let(:target_state) { 'started' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "started" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('started')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "processed_1" with "pending" requests' do
      let(:target_state) { 'processed_1' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "processed_1" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_1')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "processed_1" with "started" requests' do
      let(:target_state) { 'processed_1' }
      let(:request_state) { 'started' }

      it 'updates the tube to "processed_1" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_1')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "processed_1" with "failed" requests' do
      let(:target_state) { 'processed_1' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "processed_1" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_1')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "processed_1" with "passed" requests' do
      let(:target_state) { 'processed_1' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "processed_1" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_1')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "processed_1" with "cancelled" requests' do
      let(:target_state) { 'processed_1' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "processed_1" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_1')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "passed" with "pending" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "started" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "failed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "passed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "passed" with "passed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "passed" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "passed" with "cancelled" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "passed" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "failed" with "started" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "failed" with "passed" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "pending" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "cancelled" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "cancelled" with "started" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'started' }

      it 'updates the tube to "cancelled" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "cancelled" with "failed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "cancelled" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "passed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "cancelled" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "cancelled" with "cancelled" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "cancelled" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "pending" with "pending" requests' do
      let(:target_state) { 'pending' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "pending" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('pending')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "pending" with "started" requests' do
      let(:target_state) { 'pending' }
      let(:request_state) { 'started' }

      it 'updates the tube to "pending" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('pending')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "pending" with "failed" requests' do
      let(:target_state) { 'pending' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "pending" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('pending')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "pending" with "passed" requests' do
      let(:target_state) { 'pending' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "pending" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('pending')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "pending" with "cancelled" requests' do
      let(:target_state) { 'pending' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "pending" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('pending')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end

  context 'when the tube is: "processed_1"' do
    let(:transfer_request_state) { 'processed_1' }

    context 'when transitioning to "processed_2" with "pending" requests' do
      let(:target_state) { 'processed_2' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "processed_2" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_2')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "processed_2" with "started" requests' do
      let(:target_state) { 'processed_2' }
      let(:request_state) { 'started' }

      it 'updates the tube to "processed_2" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_2')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "processed_2" with "failed" requests' do
      let(:target_state) { 'processed_2' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "processed_2" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_2')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "processed_2" with "passed" requests' do
      let(:target_state) { 'processed_2' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "processed_2" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_2')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "processed_2" with "cancelled" requests' do
      let(:target_state) { 'processed_2' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "processed_2" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('processed_2')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "failed" with "started" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "failed" with "passed" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "pending" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "cancelled" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "cancelled" with "started" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'started' }

      it 'updates the tube to "cancelled" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "cancelled" with "failed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "cancelled" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "passed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "cancelled" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "cancelled" with "cancelled" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "cancelled" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end

  context 'when the tube is: "started"' do
    let(:transfer_request_state) { 'started' }

    context 'when transitioning to "passed" with "pending" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "started" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "failed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "passed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "passed" with "passed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "passed" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "passed" with "cancelled" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "passed" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "failed" with "started" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "failed" with "passed" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "pending" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "cancelled" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "cancelled" with "started" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'started' }

      it 'updates the tube to "cancelled" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "cancelled" with "failed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "cancelled" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "passed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "cancelled" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "cancelled" with "cancelled" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "cancelled" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end

  context 'when the tube is: "failed"' do
    let(:transfer_request_state) { 'failed' }

    context 'when transitioning to "passed" with "pending" requests' do
      # This is a little odd, but its because we filter out failed/cancelled
      # transfer requests before transitioning the tube.
      # As far as I'm aware we're not currently passing/failing a subset of transfer
      # requests into a tube.
      # We would probably be safe to let this behaviour change.
      let(:target_state) { 'passed' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "passed" with "started" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "failed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "passed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "passed" with "passed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "passed" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "passed" with "cancelled" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "passed" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end

  context 'when the tube is: "processed_2"' do
    let(:transfer_request_state) { 'processed_2' }

    context 'when transitioning to "passed" with "pending" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "started" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "passed" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "passed" with "failed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "passed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "passed" with "passed" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "passed" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "passed" with "cancelled" requests' do
      let(:target_state) { 'passed' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "passed" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('passed')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "failed" with "started" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "failed" with "passed" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "pending" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "cancelled" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "cancelled" with "started" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'started' }

      it 'updates the tube to "cancelled" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "cancelled" with "failed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "cancelled" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "passed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "cancelled" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "cancelled" with "cancelled" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "cancelled" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end

  context 'when the tube is: "passed"' do
    let(:transfer_request_state) { 'passed' }

    context 'when transitioning to "failed" with "started" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'started' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "failed" with "passed" requests' do
      let(:target_state) { 'failed' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "failed" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('failed')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "pending" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "cancelled" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "cancelled" with "started" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'started' }

      it 'updates the tube to "cancelled" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "cancelled" with "failed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "cancelled" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "passed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "cancelled" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "cancelled" with "cancelled" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "cancelled" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('cancelled')
      end
    end

    context 'when transitioning to "qc_complete" with "pending" requests' do
      let(:target_state) { 'qc_complete' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "qc_complete" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('qc_complete')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "qc_complete" with "started" requests' do
      let(:target_state) { 'qc_complete' }
      let(:request_state) { 'started' }

      it 'updates the tube to "qc_complete" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('qc_complete')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "qc_complete" with "failed" requests' do
      let(:target_state) { 'qc_complete' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "qc_complete" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('qc_complete')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "qc_complete" with "passed" requests' do
      let(:target_state) { 'qc_complete' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "qc_complete" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('qc_complete')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "qc_complete" with "cancelled" requests' do
      let(:target_state) { 'qc_complete' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "qc_complete" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('qc_complete')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end

  context 'when the tube is: "qc_complete"' do
    let(:transfer_request_state) { 'qc_complete' }

    context 'when transitioning to "cancelled" with "pending" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'pending' }

      it 'updates the tube to "cancelled" with "pending" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('pending')
      end
    end

    context 'when transitioning to "cancelled" with "started" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'started' }

      it 'updates the tube to "cancelled" with "started" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('started')
      end
    end

    context 'when transitioning to "cancelled" with "failed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'failed' }

      it 'updates the tube to "cancelled" with "failed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('failed')
      end
    end

    context 'when transitioning to "cancelled" with "passed" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'passed' }

      it 'updates the tube to "cancelled" with "passed" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('passed')
      end
    end

    context 'when transitioning to "cancelled" with "cancelled" requests' do
      let(:target_state) { 'cancelled' }
      let(:request_state) { 'cancelled' }

      it 'updates the tube to "cancelled" with "cancelled" requests', aggregate_failures: true do
        expect(transfer_request.reload.state).to eq('cancelled')
        expect(request.reload.state).to eq('cancelled')
      end
    end
  end
end
