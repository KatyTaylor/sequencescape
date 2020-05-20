# frozen_string_literal: true

# This file was automatically generated by `rails g record_loader`
module RecordLoader
  # This forms the standard base class for record loaders in your
  # application, allowing for easy configuration.
  # @see https://rubydoc.info/github/sanger/record_loader/
  class ApplicationRecordLoader < RecordLoader::Base
    # Uses the standard RailsAdapter
    # @see https://rubydoc.info/github/sanger/record_loader/RecordLoader/Adapter
    adapter RecordLoader::Adapter::Rails.new
  end
end
