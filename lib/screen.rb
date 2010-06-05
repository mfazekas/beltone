class Screen

  attr_accessor :content, :cursor_x, :cursor_y

  def set_cursor x,y
    @cursor_x = x
    @cursor_y = y
  end

  def text message
    @content = message
  end

end