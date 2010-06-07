require 'net/telnet'
require 'parser'
require 'screen'
require 'vt220_input_commands'

class TerminalSession
  def initialize host, port = 23, timeout = 30

    @telnet_session = Net::Telnet.new(
            "Host"    => host,
            "Port"    => port,
            "Timeout" => timeout
    )
    @screen = Screen.new
    @parser = Parser.new(@screen)
  end

  def login user, password
    @telnet_session.login user, password
    @sock =  @telnet_session.sock
  end

  def close
    @telnet_session.close
  end

  def listen timeout
    incoming = ''
    length = 1
    while incoming.length != length do
      length = incoming.length
      if IO::select([@sock], nil, nil, timeout)
        incoming << @sock.readpartial(1024)
      end
    end
    incoming
  end

  def send outgoing, timeout = 1
    outgoing = COMMANDS[outgoing] if COMMANDS[outgoing]
    puts "Sending: #{outgoing.inspect}"
    @sock.print outgoing
    incoming =  listen timeout
    puts "receiving: #{incoming.inspect}"
    @parser.read_tokens incoming
    puts @screen.display
  end
end

#Copyright 2010 Michael Bain
#This file is licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
#http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.