module Pipeline::RequestsInStorage # rubocop:todo Style/Documentation
  def ready_in_storage
    send((proxy_association.owner.group_by_parent ? :asset_on_labware : :all))
  end
end
