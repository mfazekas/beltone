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

  it "should return nil if the vt command doesn't matches it pattern" do
    @output_pattern.match('abc 123').should == nil
  end
end

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.