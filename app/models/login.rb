class Login

  attr_accessor :client

  def initialize(connection, client)
    @client = client
    @connection = connection
  end

  def proceed client
    @connection.puts ":red:Enter password:"
    password = @connection.gets.chomp
    if client.password == password
      #@client.email = client.email
      @client = client
      @client.connection = @connection
      @connection.puts ':green:successfully logged in ...'
    else
      @connection.puts ':red:password incorrect, disconnecting...'
      @connection.close
    end
  end

  def create_client email
    @connection.puts ":yellow:Please enter a password, remember this:"
    password = @connection.gets.chomp
    client = Client.create(email: email, password: password)
    @connection.puts ':green:sucessfully created account'
    @client = client
    @client.connection = @connection
    #@client.email = client.email
  end

  def create email
    @connection.puts ":red:Email does not exist, do you want to create this account?(y/n)"
    answer = @connection.gets.chomp
    if answer == 'y'
      create_client email
    else
      @connection.puts ':red:DISCONNECTING ...'
      @connection.close
    end
  end

  def start 
    @connection.puts ':yellow:Enter email: '
    email = @connection.gets.chomp
    client = Client.find_by_email(email)
    if client
      proceed client
    else
      create email
    end

  end

end
