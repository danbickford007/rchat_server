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
        welcome = Welcome.new(connection, client)
        client = welcome.greet 
        client.category = welcome.choose_category
        @clients << client
        listen_for_clients client
      end
    }.join
  end

  def listen_for_clients client
    loop{
      message = client.connection.gets.chomp    
      if message.present? 
        command = Command.new(client.connection)
        if command.is_command(message)
          command.issue client, message
        else
          broadcast message, client
        end
      end
    }
  end

  def broadcast message, broadcasting_client
    History.create(content: "#{broadcasting_client.email}: #{message}", category_id:broadcasting_client.category.id)
    @clients.each do |client|
      begin
        if broadcasting_client.category == client.category
          client.connection.puts ":blue:#{broadcasting_client.email}: #{message}"
        end
      rescue
        p 'REMOVING CLIENT'
        client.connection.close
        @clients.remove(client)
      end
    end
  end

end
