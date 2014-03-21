class Welcome

  def initialize(client)
    @client = client
  end

  def greet
    @client.puts 'Welcome ...'
  end

end
