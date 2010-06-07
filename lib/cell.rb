class Cell
  attr_accessor :character

  def initialize
    @character = ' '
  end

  def erase
    @character = ' '
  end

  def to_s
    @character
  end

end