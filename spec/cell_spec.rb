require "spec"
require 'cell'

describe "cell" do

  before (:each) do
    @cell = Cell.new
  end

  it "should start out storing a space" do
    @cell.character.should == ' '
  end

  it "should store a character" do
    @cell.character='v'
    @cell.character.should == 'v'
  end

  it "should erase itself when asked nicely" do
    @cell.character='4'
    @cell.erase
    @cell.character.should == ' '
  end


end