class Server 

  def initialize(ip, port)
    @server = TCPServer.open(ip, port)
    @clients = [] 
    run
  end

  def run
    loop{
      Thread.start(@server.accept) do |connection|
        client = Client.new
        client.set_connection(connection)
        @clients << client
        welcome = Welcome.new(connection)
        welcome.greet
        client.category = welcome.choose_category
        listen_for_clients
      end
    }
  end

  def listen_for_clients
    loop{
      @clients.each do |client|
        message = client.connection.gets.chomp     
        broadcast message
      end 
    }
  end

  def broadcast message
    @clients.each do |client|
      client.connection.puts message
    end
  end

end
