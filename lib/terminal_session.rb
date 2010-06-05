require 'net/telnet'

class TerminalSession
  def initialize host, port = 23, timeout = 30

    @telnet_session = Net::Telnet.new(
            "Host"       => host,
            "Timeout"   => timeout
    )
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

  def send arg, timeout = 1
    @sock.print arg
    message =  listen timeout
    puts "receiving: '#{message.inspect}'"
  end
end