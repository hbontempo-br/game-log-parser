# frozen_string_literal: true

# Class to represent a Game's Player
class Player < String
  class PlayerError < StandardError; end

  # Error received when trying to initialize a Player with a invalid parameter (not s String)
  class InvalidPlayerError < PlayerError
    # @return [String]
    def message
      'Invalid player, player\'s name must be a String'
    end
  end

  # @param name [String] Player's name
  # @return [Player]
  # @raise [InvalidPlayerError]
  def initialize(name)
    raise InvalidPlayerError unless name.is_a? String

    super(name)
  end
end
