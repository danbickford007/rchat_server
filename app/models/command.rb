class Command

  def initialize(connection)
    @connection = connection
  end

  def is_command(txt)
    txt.first == ':'
  end

  def issue client, com
    category = Category.new
    category.set_connection @connection, client
    if com.match(/:category:/)
      cat = com.split(/:category:/)[1]
      category.set(client, cat)
    elsif com.match(/:categories:/)
      category.show_all client
    end
    client
  end

end
