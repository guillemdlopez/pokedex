# repository (where all the pokemons are stored)
require 'csv'
require_relative 'pokemon'

class Pokedex
    def initialize(csv_file)
        @csv_file = csv_file
        @pokemons = []
        load_csv_file
    end

    def all
        @pokemons
    end

    def add_pokemon(pokemon)
        @pokemons << pokemon
        save
    end

    def dead_pokemon(pokemon)
        pokemon.dead!
        save
    end

    def set_to_life(pokemons)
        pokemons.each do |pokemon|
            pokemon.relive!
        end

        save
    end

    def upgrade_level(pokemon)
        pokemon.upgrade_level!
        save
    end

    def load_csv_file
        CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
            @pokemons << Pokemon.new(row[0], row[1], row[2], row[3], row[4], row[5].to_i, row[6].to_i)
        end
    end

    def save
        CSV.open(@csv_file, "wb") do |csv|
            csv << ["id", "name", "height", "weigth", "abilities", "level", "life"]
            @pokemons.each do |pokemon|
                csv << [pokemon.id, pokemon.name, pokemon.height, pokemon.weight, pokemon.abilities, pokemon.level, pokemon.life]
            end
        end
    end
end