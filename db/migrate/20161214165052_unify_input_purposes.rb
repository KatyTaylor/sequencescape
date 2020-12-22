# Rails migration
class UnifyInputPurposes < ActiveRecord::Migration
  class Purpose < ApplicationRecord # rubocop:todo Style/Documentation
    self.inheritance_column = nil
    self.table_name = 'plate_purposes'
  end

  UNIFIED_PURPOSE = 'PlatePurpose::Input'.freeze
  NAME_OLD_PURPOSE = [
    ['ILB_STD_INPUT', 'IlluminaHtp::StockPlatePurpose'],
    ['Cherrypicked', 'IlluminaHtp::StockPlatePurpose'],
    ['PF Cherrypicked', 'IlluminaHtp::StockPlatePurpose'],
    ['WGS stock DNA', 'Pulldown::StockPlatePurpose'],
    ['SC stock DNA', 'Pulldown::StockPlatePurpose'],
    ['ISC stock DNA', 'Pulldown::StockPlatePurpose']
  ].freeze

  def up
    ActiveRecord::Base.transaction do
      NAME_OLD_PURPOSE.each do |name, _old_purpose|
        purp = Purpose.find_by(name: name)
        purp.type = UNIFIED_PURPOSE
        purp.save!
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      NAME_OLD_PURPOSE.each do |name, old_purpose|
        purp = Purpose.find_by(name: name)
        purp.type = old_purpose
        purp.save!
      end
    end
  end
end
