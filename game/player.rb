class Player < String

  class PlayerError < StandardError; end

  class InvalidPlayerError < PlayerError
    def message
      "Invalid player, player's name must be a String"
    end
  end

  def initialize(name)
    raise InvalidPlayerError unless name.is_a? String
    super(name)
  end

end