require "spec"
require "output_pattern"
require "vt220_output_builder"

describe "output processor" do

  before(:each) do
    @mock = mock("anything")
    @vt_output = Vt220OutputBuilder.new
    @output_pattern = OutputPattern.new("test", /(\d+) \w+/) { |number| @mock.do number }
  end

  it "should return it's description" do
    @output_pattern.description.should == 'test'
  end

  it "should match run the block and return the rest of the tokens if the vt command matches it pattern" do
    @mock.should_receive(:do).with '123'
    @output_pattern.match('123 word').should == ''
  end

  it "should return false if the vt command doesn't matches it pattern" do
    @output_pattern.match('abc 123').should == false
  end

end
