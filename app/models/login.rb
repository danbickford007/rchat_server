class Login

  def initialize(connection)
    @connection = connection
  end

  def proceed client
    @connection.puts "Enter password:"
    password = @connection.gets.chomp
    if client.password == password
      @connection.puts 'successfully logged in ...'
    else
      @connection.puts 'password incorrect, disconnecting...'
      @connection.close
    end
  end

  def create
    @connection.puts "Email does not exist, do you want to create this account?(y/n)"
    answer = @connection.gets.chomp
    if answer == 'y'
      @connection.puts "Please enter your password:"
      password = @connection.gets.chomp
      client = Client.create(email: email, password: password)
      @connection.puts 'sucessfully created account'
    else
      @connection.puts 'DISCONNECTING ...'
      @connection.close
    end
  end

  def start
    @connection.puts 'Enter email: '
    email = @connection.gets.chomp
    client = Client.find_by_email(email)
    if client
      proceed client
    else
      create
    end

  end

end
