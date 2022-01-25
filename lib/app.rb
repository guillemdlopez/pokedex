require_relative 'pokedex' # repo
require_relative 'controller' # in between the view and the repo
require_relative 'router'

csv_file = File.join(__dir__, 'pokemons.csv')
pokedex = Pokedex.new(csv_file)
controller = Controller.new(pokedex)
router = Router.new(controller)

# init application
router.run