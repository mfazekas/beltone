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
    @parser.read_tokens @vt_output.set_cursor(33, 6).text("wow").to_s
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

  it "should set the cursors horizontal position" do
     @mock_screen.should_receive(:set_cursor_x).with 14
    @parser.parse_token @vt_output.set_cursor_x(15).to_s
  end

  it "should move the cursor" do
    @mock_screen.should_receive(:set_cursor).with 2, 3
    @parser.parse_token @vt_output.set_cursor(3, 4).to_s
  end

  it "should return the cursor to home" do
    @mock_screen.should_receive(:home_cursor).with no_args()
    @parser.parse_token @vt_output.home_cursor.to_s
  end

  it 'should move the cursor right' do
    @mock_screen.should_receive(:move_cursor_right).with 1
    @parser.parse_token @vt_output.move_cursor(:right).to_s
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

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
