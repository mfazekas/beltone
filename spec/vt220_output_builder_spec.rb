require "spec"
require "vt220_output_builder"

describe "VT220 output builder" do

  before(:each) do
    @vt_command = Vt220OutputBuilder.new
  end

  it "should write some text" do
    @vt_command.text("plain text").to_s.should == "plain text"
  end
end