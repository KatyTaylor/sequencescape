module ApplicationRecord::StringSanitizer
  def self.extended(base)
    base.instance_eval do
      def squishify(*names)
        class_eval do
          before_validation do |record|
            names.each do |name|
              value = record.send(name)
              record.send(name.to_s + '=', value.squish) if value.is_a? String
            end
          end
        end
      end
    end
  end
end

class ApplicationRecord
  extend ApplicationRecord::StringSanitizer
end
