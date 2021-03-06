class Welcome

  def initialize(connection, client)
    @connection = connection
    @client = client
  end

  def greet 
    @connection.puts ':blue:Welcome ...'
    login 
  end

  def login 
    log_in = Login.new(@connection, @client)
    log_in.start 
    log_in.client
  end

  def choose_category
    @connection.puts ':yellow:Please choose a category...'
    category = Category.new
    category.set_connection @connection, @client
    category.show_all
    category.get_choice
  end

end
