class Welcome

  def initialize(connection)
    @connection = connection
  end

  def greet
    @connection.puts 'Welcome ...'
    login
  end

  def login
    log_in = Login.new(@connection)
    log_in.start
  end

  def choose_category
    @connection.puts 'Please choose a category...'
    category = Category.new
    category.set_connection @connection
    category.show_all
    category.get_choice
  end

end
