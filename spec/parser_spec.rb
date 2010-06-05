require "spec"
require "parser"
require "vt220_output_builder"

describe "parser" do
  before (:each) do
    @parse = Parser.new
    @vt_output = Vt220OutputBuilder.new
  end

  it "should have some default patterns" do
    @parse.patterns.size.should > 0
  end

  it "should parse a token" do
    mock_output_pattern = mock('anything')
    mock_output_pattern.should_receive(:match).with('abc 123').and_return(true)
    @parse.patterns= [mock_output_pattern]
    @parse.token(@vt_output.text('abc 123').to_s)
  end

end