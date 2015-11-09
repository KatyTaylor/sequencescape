#This file is part of SEQUENCESCAPE is distributed under the terms of GNU General Public License version 1 or later;
#Please refer to the LICENSE and README files for information on licensing and authorship of this file.
#Copyright (C) 2007-2011 Genome Research Ltd.
require 'rest-client'

module LabWhereClient

  class LabWhere
    include Singleton
    def base_url
      configatron.labwhere_api
    end

    def path_to(instance, target)
      [base_url, instance.endpoint, target].join('/')
    end

    def parseJSON(str)
      return nil if str=='null'
      JSON.parse(str)
    end

    def get(instance, target)
      parseJSON(RestClient.get(path_to(instance,target)))
    rescue Errno::ECONNREFUSED => e
      raise LabwhereException.new(e), "LabWhere service is down", e.backtrace
    end

    def post(instance, target, payload)
    end

  end

  class Endpoint

    def self.endpoint_name(name)
      @endpoint = name
    end

    class << self
      attr_reader :endpoint
    end

    def initialize(params)
    end
  end

  LabwhereException = Class.new(StandardError)

  class Labware < Endpoint
    endpoint_name 'labwares'

    attr_reader :barcode
    attr_reader :location

    def self.find_by_barcode(barcode)
      attrs = LabWhere.instance.get(self, barcode)
      new(attrs) unless attrs.nil?
    end

    def initialize(params)
      @barcode = params['barcode']
      @location = Location.new(params['location'])
    end
  end

  class Scan < Endpoint
    endpoint_name 'scans'
  end

  class Location < Endpoint
    endpoint_name 'locations'

    attr_reader :name
    attr_reader :parentage

    def initialize(params)
      @name = params['name']
      @parentage = params['parentage']
    end

    def location_info
      [name, parentage].join(' - ')
    end
  end

  class LocationType < Endpoint
    endpoint_name 'location_types'
  end
end