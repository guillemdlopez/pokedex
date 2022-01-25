require_relative 'api_request.rb'
require_relative 'view.rb'
require 'json'

class ParseRequest
    def parse_json(json)
        JSON.parse(json.body)
    end
end