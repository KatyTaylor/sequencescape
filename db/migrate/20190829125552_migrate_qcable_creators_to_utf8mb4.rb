# frozen_string_literal: true

# Autogenerated migration to convert qcable_creators to utf8mb4
class MigrateQcableCreatorsToUtf8mb4 < ActiveRecord::Migration[5.1]
  include MigrationExtensions::EncodingChanges

  def change
    change_encoding('qcable_creators', from: 'utf8', to: 'utf8mb4')
  end
end
