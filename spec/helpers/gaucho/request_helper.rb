require 'rails_helper'
# require 'devise/hooks/proxy'

module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body, symbolize_names: true)
    end

    def included_ids_with_type
      included_ids_with_type_array = []
      if json[:included].present?
        json[:included].each do |included_hash|
          containter_array = [] << included_hash[:id].to_i
          containter_array << included_hash[:type]
          included_ids_with_type_array << containter_array
        end
      end
      return included_ids_with_type_array
    end

  end
end