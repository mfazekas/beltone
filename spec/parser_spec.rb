require "spec"
require "parser"
require "vt220_output_builder"

describe "parser" do
  before (:each) do
    @parser = Parser.new
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

  it "should parse several tokens" do
    @parser.read_tokens(@vt_output.set_cursor(32, 5).text("wow").to_s)
  end

end