class RequestFactory
  def self.copy_request(request)
    ActiveRecord::Base.transaction do
      raise Quota::Error.new, "Insufficient quota for #{request.request_type.name}" unless request.has_quota?(1)

      request.class.create!(request.attributes) do |request_copy|
        request_copy.target_asset_id = nil
        request_copy.state           = "pending"
        request_copy.create_request_metadata(request.request_metadata.attributes)
        request_copy.created_at      = Time.now

        request.quotas.each do |q|
          q.add_request!(request_copy, false, q.project.enforce_quotas?)
        end
      end
    end
  end

  def self.create_assets_requests(assets, study)
    # internal requests to link study -> request -> asset -> sample
    # TODO: do this as a submission
    request_type = RequestType.find_by_key('create_asset') or raise StandardError, "Cannot find create asset request type"
    assets.each { |asset| request_type.create!(:study => study, :asset => asset, :state => 'passed') }
  end
end
