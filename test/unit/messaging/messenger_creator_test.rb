# This file is part of SEQUENCESCAPE; it is distributed under the terms of
# GNU General Public License version 1 or later;
# Please refer to the LICENSE and README files for information on licensing and
# authorship of this file.
# Copyright (C) 2015 Genome Research Ltd.

require 'test_helper'

class MessengerCreatorTest < ActiveSupport::TestCase
  context '#messenger_creator' do
    setup do
      @purpose = FactoryGirl.build :plate_purpose
      @plate =   FactoryGirl.build :plate, plate_purpose: @purpose
    end

    context 'with SelfFinder' do
      setup do
        @messenger_creator = FactoryGirl.build :messenger_creator, purpose: @purpose
        @start_count = Messenger.count
      end

      should 'create a messenger' do
        @messenger = @messenger_creator.create!(@plate)
        assert @messenger.is_a?(Messenger)
        assert_equal @messenger.target, @plate
        assert_equal @messenger.root, 'a_plate'
        assert_equal @messenger.template, 'FluidigmPlateIO'
      end

      should 'be handled automatically by the purpose' do
        @purpose.messenger_creators << @messenger_creator
        @plate.cherrypick_completed
        assert_equal 1, Messenger.count - @start_count
      end
    end

    context 'with WellFinder' do
      setup do
        @messenger_creator = build :messenger_creator, purpose: @purpose, target_finder_class: 'WellFinder', root: 'well'
        @start_count = Messenger.count
        @plate.save
        3.times { @plate.wells << build(:well) }
      end

      should 'create a messenger' do
        @messengers = @messenger_creator.create!(@plate)
        assert @messengers.is_a?(Array)
        assert_equal 3, @messengers.length

        @plate.wells.each do |well|
          assert_includes @messengers.map(&:target), well
        end

        assert_equal @messengers.first.root, 'well'
        assert_equal @messengers.first.template, 'FluidigmPlateIO'
      end

      should 'be handled automatically by the purpose' do
        @purpose.messenger_creators << @messenger_creator
        @plate.cherrypick_completed
        assert_equal 3, Messenger.count - @start_count
      end
    end
  end
end
