class Pokemon
    attr_reader :id, :name, :height, :weight, :abilities
    attr_accessor :life, :level

    def initialize(id, name, height, weigth, abilities, level, life)
        @id = id
        @name = name
        @height = height
        @weight = weigth
        @abilities = abilities
        @level = level
        @life = life
    end

    def dead_pokemon?
        @life.zero?
    end

    def level?
        @level
    end

    def relive!
        @life = 100
    end

    def dead!
        @life = 0
    end

    def upgrade_level!
        @level += 1
    end
end