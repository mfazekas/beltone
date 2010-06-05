require "spec"
require "parser"
require "vt220_output_builder"

describe "parser" do
  before (:each) do
    @mock_screen = mock('Screen')
    @parser = Parser.new @mock_screen
    @vt_output = Vt220OutputBuilder.new
  end

  it "should have some default patterns" do
    @parser.patterns.size.should > 0
  end

  it "should parse a token" do
    mock_output_pattern = mock('anything')
    mock_output_pattern.should_receive(:match).with('abc 123').and_return(true)
    @parser.patterns= [mock_output_pattern]
    @parser.parse_token(@vt_output.text('abc 123').to_s)
  end

  it "should parse several tokens and talk to the screen" do
    @mock_screen.should_receive(:set_cursor).with 32, 5
    @mock_screen.should_receive(:text).with 'wow'
    @parser.read_tokens @vt_output.set_cursor(32, 5).text("wow").to_s
  end

  it "should enter text" do
    @mock_screen.should_receive(:text).with 'one day'
    @parser.parse_token @vt_output.text('one day').to_s
  end

end

describe "moving the cursor" do
  before (:each) do
    @mock_screen = mock('Screen')
    @parser = Parser.new @mock_screen
    @vt_output = Vt220OutputBuilder.new
  end

  it "should move the cursor" do
    @mock_screen.should_receive(:set_cursor).with 2, 3
    @parser.parse_token @vt_output.set_cursor(2, 3).to_s
  end
end


describe "erasing things" do
  before (:each) do
    @mock_screen = mock('Screen')
    @parser = Parser.new @mock_screen
    @vt_output = Vt220OutputBuilder.new
  end

  it "should erase to the end of the line" do
    @mock_screen.should_receive(:erase_to_end_of_line).with no_args
    @parser.parse_token @vt_output.erase(:to_end_, :line).to_s
  end

  it "should erase to the beginning of the line" do
    @mock_screen.should_receive(:erase_to_beginning_of_line).with no_args
    @parser.parse_token @vt_output.erase(:to_beginning, :line).to_s
  end

  it "should erase to the entire line" do
    @mock_screen.should_receive(:erase_entire_of_line).with no_args
    @parser.parse_token @vt_output.erase(:entire, :line).to_s
  end

  it "should erase to the screen" do
    @mock_screen.should_receive(:erase_entire_of_screen).with no_args
    @parser.parse_token @vt_output.erase(:entire, :screen).to_s
  end

  it "should erase to the end of the screen" do
    @mock_screen.should_receive(:erase_to_end_of_screen).with no_args
    @parser.parse_token @vt_output.erase(:to_end_, :screen).to_s
  end

  it "should erase to the beginning of the screen" do
    @mock_screen.should_receive(:erase_to_beginning_of_screen).with no_args
    @parser.parse_token @vt_output.erase(:to_beginning, :screen).to_s
  end

end