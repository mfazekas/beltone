require 'net/telnet'
require 'parser'
require 'screen'

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
    puts "Sending: '#{outgoing}'"
    @sock.print outgoing
    incoming =  listen timeout
    puts "receiving: '#{incoming.inspect}'"
    @parser.read_tokens incoming
  end
end