require "spec"
require "screen"

describe "Screen" do

  before (:each) do
    @screen = Screen.new
  end

  it "should display text" do
    @screen.text "hello"
    @screen.content.should == "hello"
  end

  it "should move the cursor" do
    @screen.set_cursor 50,10
    @screen.cursor_x.should == 50
    @screen.cursor_y.should == 10
  end
end