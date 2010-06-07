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

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.