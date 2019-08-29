# frozen_string_literal: true

# Autogenerated migration to convert lot_types to utf8mb4
class MigrateLotTypesToUtf8mb4 < ActiveRecord::Migration[5.1]
  include MigrationExtensions::EncodingChanges

  def change
    change_encoding('lot_types', from: 'utf8', to: 'utf8mb4')
  end
end