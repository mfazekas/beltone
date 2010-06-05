require "spec"
require 'cell'

describe "cell" do

  before (:each) do
    @cell = Cell.new
  end
  it "should store a character" do
    @cell.character='v'
    @cell.character.should == 'v'
  end
end