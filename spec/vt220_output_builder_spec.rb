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

    it "should create a set the cursor to some coordinates" do
      @vt_command.set_cursor(64, 10).to_s.should match /^\e\[10;64[H|f]$/
    end

    it "should move the cursor then write some text" do
      @vt_command.set_cursor(40, 1).text(" hello").should.to_s == "\e[1;40H hello"
    end

    it "should move the cursor up" do
      @vt_command.move_cursor(:up).should.to_s == "\e[1A"
      @vt_command.move_cursor(:up, 7).should.to_s == "\e[7A"
    end

    it "should move the cursor down" do
      @vt_command.move_cursor(:down).should.to_s == "\e[1B"
    end

    it "should move the cursor left" do
      @vt_command.move_cursor(:left).should.to_s == "\e[1D"
    end

    it "should move the cursor right" do
      @vt_command.move_cursor(:right).should.to_s == "\e[1C"
    end

    it "should move the cursor back to home" do
      @vt_command.home_cursor.to_s.should match /^\e\[[H|f]$/
    end

    it "should erase things" do
      @vt_command.erase(:entire, :line).should.to_s == "\e[2K"
      @vt_command.erase(:to_end, :line).should.to_s == "\e[K"
      @vt_command.erase(:to_beginning, :line).should.to_s == "\e[1K"

      @vt_command.erase(:entire, :screen).should.to_s == "\e[2J"
      @vt_command.erase(:to_end, :screen).should.to_s == "\e[J"
      @vt_command.erase(:to_beginning, :screen).should.to_s == "\e[1J"
    end

  end

end