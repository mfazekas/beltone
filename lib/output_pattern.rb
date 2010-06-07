class OutputPattern
  attr_reader :description, :command_pattern

  def initialize description, command_pattern, & block
    @description = description
    @command_pattern = command_pattern
    @block = block
  end

  def match tokens
    match = @command_pattern.match(tokens)
    if match
      args = match.to_a
      args.shift
      run *args
      #puts "matched #{@description}: #{match.inspect}"
      #puts match.post_match.inspect
      return match.post_match
      else
      return nil
    end
  end

  def run *args
    @block.call *args
  end
end

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.