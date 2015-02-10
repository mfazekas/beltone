require "screen"

describe "Screen" do

  describe "new screen behaviour" do

    before (:each) do
      @screen = Screen.new
    end

    it "should set the cursor to 0, 0" do
      @screen.cursor_y.should == 0
      @screen.cursor_x.should == 0
    end

    it "should be 80 * 24" do
      @screen.lines.size.should == 80
      @screen.lines[0].size.should == 24
    end

  end


  describe "entering text" do
    before (:each) do
      @screen = Screen.new
    end

    it "should enter text" do
      @screen.text "hello"
      @screen.line(0).should == "hello" + ' ' * 75
    end
  end

  describe "moving the cursor" do
    before (:each) do
      @screen = Screen.new
    end

    it "should display text" do
      @screen.text "hello"
      @screen.line(0).should == "hello" + ' ' * 75
    end

    it "should move the cursor" do
      @screen.set_cursor 50, 10
      @screen.cursor_x.should == 50
      @screen.cursor_y.should == 10
    end

    it "should move the cursor home" do
      #todo: workout if home should put the cursor to 0,0 or 0,current line
      @screen.set_cursor 31, 3
      @screen.home_cursor
      @screen.cursor_x.should == 0
      @screen.cursor_y.should == 3
    end

    it "should return a string representation of the screen" do
      @screen.to_s.should == (' ' * 80 + "\n") * 24
    end

    it "should new line the cursor" do
      @screen.set_cursor 43, 12
      @screen.new_line
      @screen.cursor_x.should == 0
      @screen.cursor_y.should == 13
    end

    it "should move the cursor right" do
      @screen.move_cursor_right
      @screen.cursor_x.should == 1
      @screen.cursor_y.should == 0
    end

    it "should set the cursors horizontal position" do
      @screen.set_cursor 1,1
      @screen.set_cursor_x 67
      @screen.cursor_x.should == 67
      @screen.cursor_y.should == 1

    end
  end

  describe "erasing sections" do
    before (:each) do
      @screen = Screen.new
    end

    it "erase to the end of the line" do
      @screen.text "0123456789" + '.' * 70
      @screen.set_cursor 5, 0
      @screen.erase_to_end_of_line
      @screen.line(0).should == "01234" + ' ' * 75
    end

    it "should erase the entire screen" do
      @screen.lines.each do |a_vertical_line|
        (a_vertical_line).each do |a_cell|
          a_cell.character= "."
        end
      end
      @screen.erase_entire_of_screen
      @screen.to_s.should == (' ' * 80 + "\n") * 24
    end
  end
end

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.