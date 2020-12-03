# frozen_string_literal: true

require 'rails_helper'
require './app/resources/api/v2/tube_resource'

RSpec.describe Api::V2::TubeResource, type: :resource do
  subject(:resource) { described_class.new(resource_model, {}) }

  let(:resource_model) { create :tube, barcode_number: 1 }

  # Test attributes
  it 'works', :aggregate_failures do
    expect(subject).to have_attribute :uuid
    expect(subject).to have_attribute :name
    expect(subject).not_to have_updatable_field(:id)
    expect(subject).not_to have_updatable_field(:uuid)
    expect(subject).not_to have_updatable_field(:name)
    expect(subject).not_to have_updatable_field(:labware_barcode)
    expect(subject).to have_many(:samples).with_class_name('Sample')
    expect(subject).to have_many(:projects).with_class_name('Project')
    expect(subject).to have_many(:direct_submissions).with_class_name('Submission')
    expect(subject).to have_many(:studies).with_class_name('Study')
    expect(subject).to have_one(:purpose).with_class_name('Purpose')
  end

  # Custom method tests
  # Add tests for any custom methods you've added.
  describe '#labware_barcode' do
    subject { resource.labware_barcode }

    it do
      expect(subject).to eq('ean13_barcode' => '3980000001795',
                            'human_barcode' => 'NT1O',
                            'machine_barcode' => '3980000001795')
    end
  end
end
