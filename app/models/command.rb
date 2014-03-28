class Command

  def initialize(connection)
    @connection = connection
  end

  def is_command(txt)
    txt.first == ':'
  end

  def issue client, com, clients
    category = Category.new
    category.set_connection @connection, client
    if com.match(/:category:/)
      cat = com.split(/:category:/)[1]
      category.set(client, cat)
    elsif com.match(/:categories:/)
      category.show_all client
    elsif com.match(/:history:/)
      history = History.new
      history.client = client
      history.show_by_category
    elsif com.match(/:help:/)
      help client
    elsif com.match(/:exit:/)
      client.connection.puts "disconnecting..."
      client.connection.close
      clients.delete(client)
    end
    [client, clients]
  end

  def help client
    client.connection.puts ":yellow:------------HELP---------------"
    client.connection.puts ":yellow:To view chat categories, issue command ':categories:'"
    client.connection.puts ":yellow:To select a category, for example a category named 'test', issue command ':category:test' or by it's identification number, ':category:1'"
    client.connection.puts ":yellow:To view history, issue command ':history:', you will be shown a list of topics, type the identification number of the topic you wish to view history"

  end

end
