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