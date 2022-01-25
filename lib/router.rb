require_relative 'controller'
# will communicate with the Controller

class Router
    def initialize(controller)
        @running = true
        @controller = controller
    end

    def run
        while @running
            puts "App running"
            display_options
            action = gets.chomp.to_i
            print `clear`
            route_action(action)
        end
    end

    def stop
        puts "*** THE BAG IS CLOSED ***"
        @running = false
    end

    def route_action(action)
        case action
        when 1 then @controller.catch_pokemon 
        when 2 then @controller.battle
        when 3 then @controller.list
        when 4 then @controller.set_free
        when 5 then @controller.heal
        when 6 then @controller.train
        when 7 then stop
        else
            puts "Sorry, this option is not available :("
        end
    end

    def display_options # CRUD
        puts "*** THE BAG IS OPENED ***" 
        puts "1 - Let's catch a pokemon!" # create
        puts "2 - Let's battle" 
        puts "3 - See all my Pokemons" # read
        puts "4 - Set free a Pokemon" # delete
        puts "5 - Go to the Pokémon-Center!"
        puts "6 - Train a Pokémon!"
        puts "7 - Close the bag" # exit
    end
end