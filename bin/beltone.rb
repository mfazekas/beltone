#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)+'/../lib'

require 'terminal_session'
require 'config'

config = Config.new
config.load 'config/config.yml', 'skynet'

puts ""

puts "Beltone, telnetting to #{config.host}:#{config.port}"
skynet = TerminalSession.new config.host, config.port

puts "logging in as #{config.user}"
skynet.login config.user, config.password

puts "setting xterm so pico works"
skynet.send "export TERM=xterm\n"

puts "starting pico"
skynet.send "pico\n"
skynet.send "hello\n"
skynet.send "world\n"
skynet.send "_down"
skynet.send "lower?\n"



puts "type _quit to quit interactive mode"

outgoing = "m"

while not outgoing == "_quit"
  puts "type:"
  outgoing = gets.chomp
  skynet.send outgoing unless outgoing.downcase == "_quit"
end

skynet.close

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.