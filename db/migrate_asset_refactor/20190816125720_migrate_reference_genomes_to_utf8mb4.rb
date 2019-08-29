# frozen_string_literal: true

# Autogenerated migration to convert reference_genomes to utf8mb4
class MigrateReferenceGenomesToUtf8mb4 < ActiveRecord::Migration[5.1]
  include MigrationExtensions::EncodingChanges

  def change
    change_encoding('reference_genomes', from: 'latin1', to: 'utf8mb4')
  end
end