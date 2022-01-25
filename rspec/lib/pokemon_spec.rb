require_relative "../../lib/pokemon.rb"

RSpec.describe Pokemon do
    let(:pokemon) { Pokemon.new(1, "Pikachu", 4, 40, ["lightning"], 5, 100) }

    it "should create a new Pokemon" do
        expect(pokemon.name).to eq("Pikachu")
    end

    it "should display if a Pokémon is dead or not" do
        expect(pokemon.dead_pokemon?).to be false
        expect(pokemon.dead_pokemon?).not_to be true
    end

    it "should display the level of the Pokémon" do
        expect(pokemon.level).to eq(5)
    end

    it "should upgrade a Pokémon's level" do

        expect(pokemon.upgrade_level!).to eq(6)
    end

    it "should set the life of a Pokémon to 0 when it is dead" do
        life = pokemon.dead!

        expect(life).to eq(0)
    end

    it "should relive a Pokémon" do
        pokemon.dead!

        expect(pokemon.relive!).to eq(100)
    end
end