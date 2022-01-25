require 'rest-client'

class APIRequest
    def initialize
        @url = "https://pokeapi.co/api/v2/pokemon"
    end

    def random_pokemons
        RestClient.get(@url + "?limit=100", headers)
    end

    def get_info_pokemon(pokemon)
        RestClient.get(@url + "/#{pokemon}", { accept: :json })
    end

    private

    def headers
        { accept: :json }
    end
end