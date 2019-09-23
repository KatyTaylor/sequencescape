# frozen_string_literal: true

# Autogenerated migration to convert tag_groups to utf8mb4
class MigrateTagGroupsToUtf8mb4 < ActiveRecord::Migration[5.1]
  include MigrationExtensions::EncodingChanges

  def change
    change_encoding('tag_groups', from: 'latin1', to: 'utf8mb4')
  end
end
