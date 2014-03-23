class Login

  attr_accessor :client

  def initialize(connection, client)
    @client = client
    @connection = connection
  end

  def proceed client
    @connection.puts "Enter password:"
    password = @connection.gets.chomp
    if client.password == password
      @connection.puts 'successfully logged in ...'
      @client.email = client.email
    else
      @connection.puts 'password incorrect, disconnecting...'
      @connection.close
    end
  end

  def create_client email
    @connection.puts "Please enter a password, remember this:"
    password = @connection.gets.chomp
    client = Client.create(email: email, password: password)
    @connection.puts 'sucessfully created account'
    @client.email = client.email
  end

  def create email
    @connection.puts "Email does not exist, do you want to create this account?(y/n)"
    answer = @connection.gets.chomp
    if answer == 'y'
      create_client email
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
      create email
    end

  end

end
