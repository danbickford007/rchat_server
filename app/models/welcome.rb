class Welcome

  def initialize(connection, client)
    @connection = connection
    @client = client
  end

  def greet 
    @connection.puts 'Welcome ...'
    login 
  end

  def login 
    log_in = Login.new(@connection, @client)
    log_in.start 
    log_in.client
  end

  def choose_category
    @connection.puts 'Please choose a category...'
    category = Category.new
    category.set_connection @connection
    category.show_all
    category.get_choice
  end

end
