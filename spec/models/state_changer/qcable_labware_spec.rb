# frozen_string_literal: true

# require 'rails_helper'
require 'spec_helper'

RSpec.describe StateChanger::QcableLabware do
  let(:state_changer) do
    described_class.new(
      labware: labware,
      target_state: 'exhausted',
      user: user
    )
  end
  let!(:qcable) { create :qcable, asset: labware, state: 'available' }
  let(:labware) { create :plate }
  let(:user) { create :user }

  it 'sets library type on aliquots' do
    state_changer.update_labware_state
    expect(qcable.reload.state).to eq('exhausted')
  end
end
