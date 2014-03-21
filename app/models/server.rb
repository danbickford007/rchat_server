class Server 

  def initialize(ip, port)
    @server = TCPServer.open(ip, port)
    @clients = [] 
    run
  end

  def run
    loop{
      Thread.start(@server.accept) do |client|
        @clients << Client.new(client)
        welcome = Welcome.new(client)
        welcome.greet
        listen_for_clients
      end
    }
  end

  def listen_for_clients
    loop{
      @clients.each do |client|
        p '++++++++++++++++'
        p message = client.connection.gets.chomp     
      end 
    }
  end

end
