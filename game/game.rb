require 'set'

class GameError < StandardError
  def initialize(msg = "Error on game interaction")
    super
  end
end


class Game

  class GameError < StandardError; end

  class GameInvalidPlayerError < GameError
    def message
      "Invalid Player"
    end
  end

  class GameInvalidKillError < GameError
    def message
      "Invalid Kill"
    end
  end

  class GameKillPlayerNotInGame < GameError
    def message
      "Player involved in kill not in the game"
    end
  end


  attr_reader :players, :kills

  def initialize
    @players = Set.new
    @kills = Array.new
  end

  def add_player(player)
    raise GameInvalidPlayerError unless player.is_a? Player
    @players << player
  end

  def add_kill(kill)
    raise GameInvalidKillError unless kill.is_a? Kill
    raise GameKillPlayerNotInGame unless @players.include? kill.killer and @players.include? kill.killed
    @kills.append(kill)
  end

end