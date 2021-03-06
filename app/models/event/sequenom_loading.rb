# frozen_string_literal: true

# Events dealing with genotyping results.
# Despite the name, these are no longer Sequenom processes.
class Event::SequenomLoading < Event
  def self.created_update_gender_makers!(asset, resource)
    create!(
      eventful: asset,
      message: "Updated gender results from #{resource}",
      content: resource,
      family: 'update_gender_markers'
    )
  end

  # Also used by Fluidigm etc. Legacy name.
  def self.created_update_sequenom_count!(asset, resource)
    create!(
      eventful: asset,
      message: "Updated sequenom results from #{resource}",
      content: resource,
      family: 'update_sequenom_count'
    )
  end

  def self.updated_fluidigm_plate!(asset, resource)
    create!(
      eventful: asset,
      message: "Updated fluidigm plate from #{resource}",
      content: resource,
      family: 'update_fluidigm_plate'
    )
  end
end
