class View
    def display_pokemons(pokemons)
        if pokemons.empty?
            puts "You don't have any pokemons. Go catch some!"
            return
        end
        
        print `clear`
        puts "Your Pokémon Team!!"

        pokemons.each_with_index do |pokemon, i|
            life = pokemon.life

            if life.zero?
                puts message = "Oh no! It looks like #{pokemon.name} needs to go to the Pokémon Center!"
            end

            puts "#{i + 1}. #{pokemon.name} - lvl: #{pokemon.level} | life: [#{life}%]"
        end
    end

    def display_wild_pokemon(pokemons)
        wild_pokemon = pokemons.sample(1)[0]
        name_wild_pokemon = wild_pokemon["name"]

        puts "A wild #{name_wild_pokemon.capitalize!} appeared!"

        return name_wild_pokemon
    end

    def try_catch(pokemon)
        puts "Trying to catch #{pokemon}..."

        sleep(3)

        puts "..."
        puts "......"
        puts "........."
        puts "............"

        probability = [true, false]
        result = probability.sample

        if result
            puts "Wild #{pokemon} was catched!"
            return pokemon
        else
            puts "Wild #{pokemon} escaped!"
            return nil
        end
    end

    def ask_catch_user(pokemon)
        puts "Do you want to catch this #{pokemon}? [y/n]"
        answer = gets.chomp.downcase

        if answer == "y"
            try_catch(pokemon)
        end
    end

    def battle(pokemon, your_pokemon)
        pokemons = [pokemon, your_pokemon]

        return pokemons.sample
    end

    # Ask the user if he/she wants to fight

    def ask_fight_user(pokemon)
        puts "Do you want to fight this wild #{pokemon} - lvl: #{rand(0..5)}? [y/n]"
        answer = gets.chomp.downcase

        if answer == "y"
            return true
        else
            false
        end
    end

    def ask_train_user
        puts ""
        puts "Select a Pokémon to train! [number]"
        index = gets.chomp.to_i
    end

    def display_result(result)
        puts result + "!!"
    end

    def escape
        puts "You escaped!"
    end
end