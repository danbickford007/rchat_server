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
        welcome = Welcome.new(connection, client)
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
        command = Command.new(client.connection)
        if command.is_command(message)
          command.issue message
        else
          broadcast message
        end
      end 
    }
  end

  def broadcast message
    @clients.each do |client|
      begin
        client.connection.puts "#{client.email}: #{message}"
      rescue
        p 'REMOVING CLIENT'
        @clients.remove(client)
      end
    end
  end

end
