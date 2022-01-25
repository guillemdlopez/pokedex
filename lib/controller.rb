require_relative 'controller'
require_relative 'view'
require_relative 'api_request'
require_relative 'parse_request'
require_relative 'pokemon'

class Controller
    def initialize(pokedex)
        @pokedex = pokedex # repo
        @view = View.new
        @hoenn = APIRequest.new
        @parser = ParseRequest.new
    end

    def list
        pokemons = @pokedex.all
        
        @view.display_pokemons(pokemons)
    end

    def catch_pokemon
        pokemons = get_pokemons

        # display random pokemon
        wild_pokemon = @view.display_wild_pokemon(pokemons)
        
        # catched pokemon (in case we had luck)
        pokemon = @view.ask_catch_user(wild_pokemon)       

        if pokemon # if we catched it
            # create new instance of pokemon
            raw_pokemon_info = @hoenn.get_info_pokemon(pokemon.downcase!)
            hash_pokemon_info = @parser.parse_json(raw_pokemon_info)
            id, name, height, weight, abilities = hash_pokemon_info.values_at("order", "name", "height", "weight", "abilities")
            level = rand(0..5)

            new_pokemon = Pokemon.new(id, name.capitalize!, height, weight, abilities, level, 100)

            # save the pokemon
            @pokedex.add_pokemon(new_pokemon)
            list
        end
    end

    def battle
        # mostrar wild pokemon
        pokemons = get_pokemons
        
        wild_pokemon = @view.display_wild_pokemon(pokemons)
        
        fight = @view.ask_fight_user(wild_pokemon);
        result = ""

        if fight
            puts "Please select a Pokemon: "
            list
            answer = gets.chomp.to_i
            chosen_pokemon = @pokedex.all[answer - 1]
            winner = @view.battle(wild_pokemon, chosen_pokemon.name)
            
            result += @pokedex.all.any? {|pokemon| pokemon.name == winner } ? "You won" : "You lost"
        else
            return @view.escape
        end

        if result == "You won"
            # display result
            @view.display_result(result)
            # update pokemon's level
            @pokedex.upgrade_level(chosen_pokemon)
        else
            @view.display_result(result)
            @pokedex.dead_pokemon(chosen_pokemon)
        end

        list
    end

    def heal
        # 1. Get all the dead Pokémons
        dead_pokemons = @pokedex.all.select { |pokemon| pokemon.life.zero? }

        # 2. Send them to the Pokémon-Center
        @pokedex.set_to_life(dead_pokemons)
        list
    end

    def train
        list
        index = @view.ask_train_user
        pokemon = @pokedex.all[index - 1]
        @pokedex.upgrade_level(pokemon)

        list
    end

    private

    def get_pokemons
        # raw data from the API (no parsing)
        raw_pokemons = @hoenn.random_pokemons

        # Parse data coming from the API
        pokemons = @parser.parse_json(raw_pokemons)["results"]
    end
end