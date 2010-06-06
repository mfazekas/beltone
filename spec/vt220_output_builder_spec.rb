require "spec"
require "vt220_output_builder"

describe "VT220 output builder" do

  before(:each) do
    @vt_command = Vt220OutputBuilder.new
  end

  it "should return its self so we can chain methods" do
    @vt_command.text("some text").should be_an_instance_of Vt220OutputBuilder
  end

  it "should write some text" do
    @vt_command.text("plain text").to_s.should == 'plain text'
  end

  describe "Making cursor commands" do

    before(:each) do
      @vt_command = Vt220OutputBuilder.new
    end

    it "should create a set the cursor to some coordinates" do
      @vt_command.set_cursor(64, 10).to_s.should match /^\e\[10;64[H|f]$/
    end

    it "should move the cursor then write some text" do
      @vt_command.set_cursor(40, 1).text(" hello").to_s.should match /^\e\[1;40[H|f] hello$/
    end

    it "should move the cursor up" do
      @vt_command.move_cursor(:up).to_s.should == "\e[1A"
      Vt220OutputBuilder.new.move_cursor(:up, 7).to_s.should == "\e[7A"
    end

    it "should move the cursor down" do
      @vt_command.move_cursor(:down).to_s.should == "\e[1B"
    end

    it "should move the cursor left" do
      @vt_command.move_cursor(:left).to_s.should == "\e[1D"
    end

    it "should move the cursor right" do
      @vt_command.move_cursor(:right).to_s.should == "\e[1C"
    end

    it "should move the cursor back to home" do
      @vt_command.home_cursor.to_s.should match /^\e\[[H|f]$/
    end

    it "should erase things" do
      @vt_command.erase(:entire, :line).to_s.should == "\e[2K"
      Vt220OutputBuilder.new.erase(:to_end, :line).to_s.should == "\e[K"
      Vt220OutputBuilder.new.erase(:to_beginning, :line).to_s.should == "\e[1K"

      Vt220OutputBuilder.new.erase(:entire, :screen).to_s.should == "\e[2J"
      Vt220OutputBuilder.new.erase(:to_end, :screen).to_s.should == "\e[J"
      Vt220OutputBuilder.new.erase(:to_beginning, :screen).to_s.should == "\e[1J"
    end

  end

end