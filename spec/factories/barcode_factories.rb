# frozen_string_literal: true

FactoryBot.define do
  sequence(:barcode_number) { |i| i }

  factory :barcode, aliases: [:external] do
    association(:asset, factory: :labware)
    sequence(:barcode) { |i| "EXT_#{i}_A" }
    format { 'external' }

    factory :sanger_ean13 do
      transient do
        prefix { 'DN' }
        barcode_number
      end
      format { 'sanger_ean13' }
      barcode { SBCF::SangerBarcode.new(prefix: prefix, number: barcode_number).human_barcode }

      factory :sanger_ean13_tube do
        transient do
          prefix { 'NT' }
        end
      end
    end

    factory :sanger_code39 do
      transient do
        prefix { 'DN' }
        barcode_number
      end
      format { 'sanger_code39' }
      barcode { SBCF::SangerBarcode.new(prefix: prefix, number: barcode_number).human_barcode }

      factory :sanger_code39_tube do
        transient do
          prefix { 'NT' }
        end
      end
    end

    factory :infinium do
      transient do
        prefix { 'WG' }
        suffix { 'DNA' }
        sequence(:number) { |i| i.to_s.rjust(7, '0') }
      end
      format { 'infinium' }
      barcode { "#{prefix}#{number}-#{suffix}" }
    end

    factory :fluidigm do
      transient do
        sequence(:number) { |i| '1' + i.to_s.rjust(9, '0') }
      end
      format { 'fluidigm' }
      barcode { number }
    end

    factory :cgap do
      transient do
        prefix { 'CGAP-' }
        sequence(:number) { |i| i.to_s(16).upcase }
        # we do not attempt to calculate a valid checksum here
        sequence(:suffix) { |i| (i % 16).to_s(16).upcase }
      end
      format { 'cgap' }
      barcode { "#{prefix}#{number}#{suffix}" }
    end
  end
end
