require "spec"
require "screen"

describe "Screen" do

  before (:each) do
    @screen = Screen.new
  end

  describe "new screen behaviour" do
    it "should set the cursor to 0, 0" do
      @screen.cursor_y.should == 0
      @screen.cursor_x.should == 0
    end

    it "should be 80 * 24" do
      @screen.lines.size.should == 80
      @screen.lines[0].size.should == 24
    end

  end

  describe "screen commands" do

    it "should display text" do
      @screen.text "hello"
      @screen.get_line(0).should == "hello" + ' ' * 75
    end

    it "should move the cursor" do
      @screen.set_cursor 50, 10
      @screen.cursor_x.should == 50
      @screen.cursor_y.should == 10
    end
  end
end