require 'rest-client'

module LabelPrinter
  PmbException = Class.new(StandardError)

  class PmbClient # rubocop:todo Style/Documentation
    def self.base_url
      configatron.pmb_api
    end

    def self.print_job_url
      "#{base_url}/print_jobs"
    end

    def self.printers_url
      "#{base_url}/printers"
    end

    def self.label_templates_filter_url
      "#{base_url}/label_templates?filter[name]="
    end

    def self.printers_filter_url
      "#{base_url}/printers?filter[name]="
    end

    def self.headers
      { content_type: 'application/vnd.api+json', accept: 'application/vnd.api+json' }
    end

    def self.print(attributes)
      RestClient.post print_job_url, { 'data' => { 'attributes' => attributes } }.to_json, headers
    rescue RestClient::UnprocessableEntity => e
      raise PmbException.new(e), pretty_errors(e.response)
    rescue RestClient::InternalServerError => e
      raise PmbException.new(e), ': something went wrong'
    rescue RestClient::ServiceUnavailable => e
      raise PmbException.new(e), 'is too busy. Please try again later'
    rescue Errno::ECONNREFUSED, Errno::EADDRNOTAVAIL, RestClient::BadGateway => e
      raise PmbException.new(e), 'service is down'
    end

    def self.get_label_template_by_name(name)
      JSON.parse(RestClient.get "#{label_templates_filter_url}#{name}", headers)
    rescue RestClient::UnprocessableEntity => e
      raise PmbException.new(e), pretty_errors(e.response)
    rescue RestClient::InternalServerError => e
      raise PmbException.new(e), 'something went wrong'
    rescue RestClient::ServiceUnavailable => e
      raise PmbException.new(e), 'is too busy. Please try again later'
    rescue Errno::ECONNREFUSED, Errno::EADDRNOTAVAIL, RestClient::BadGateway => e
      raise PmbException.new(e), 'service is down'
    end

    def self.register_printer(name)
      unless printer_exists?(name)
        RestClient.post printers_url, { 'data' => { 'attributes' => { 'name' => name } } }.to_json, headers
      end
    end

    def self.printer_exists?(name)
      response = JSON.parse(RestClient.get "#{printers_filter_url}#{name}", headers)
      response['data'].present?
    end

    def self.pretty_errors(errors)
      if errors.present?
        parsed_errors = JSON.parse(errors)['errors']
        case parsed_errors
        when Array
          prettify_new_errors(parsed_errors)
        when Hash
          prettify_old_errors(parsed_errors)
        end
      end
    end

    def self.prettify_new_errors(errors)
      [].tap do |error_list|
        errors.each do |error|
          attribute = error['source']['pointer'].split('/').last.humanize
          error_list << '%{attribute} %{message}' % { attribute: attribute, message: error['detail'] }
        end
      end
        .join('; ')
    end

    def self.prettify_old_errors(errors)
      [].tap do |error_list|
        errors.each do |k, v|
          error_list << '%{attribute} %{message}' % { attribute: k.capitalize + ':', message: v.join(', ') }
        end
      end
        .join('; ')
    end
  end
end
