class IlluminaB::PcrPlatePurpose < PlatePurpose
  def transition_to(plate, state, contents = nil)
    nudge_parent_plate(plate, start, contents)
    super
  end

  def nudge_parent_plate(plate, state, contents)
    case state
    when 'started_fx' then plate.parent.transition_to('started', contents)
    when 'started_mj' then plate.parent.transition_to('passed',  contents)
    end
  end
  private :nudge_parent_plate
end
