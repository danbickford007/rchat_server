class Category < ActiveRecord::Base

  attr_accessor :connection

  def set_connection connection, client
    @connection = connection
    @client = client
  end

  def show_all client=nil
    categories = Category.all
    cats = []
    categories.each do |cat|
      cats << "#{client and client.category.id == cat.id ? '*' : ''}#{cat.id}: #{cat.name}"
    end
    @connection.puts cats.join("\n")
  end

  def get_choice
    msg = @connection.gets.chomp
    cat = Category.find_by_id(msg)
    if cat
      @connection.puts "Now in category #{cat.name}"
      @client.category = cat
      last_10 @client
      cat
    else
      show_all
      get_choice
    end
  end

  def set client, cat
    if c = Category.find_by_name(cat)
      client.category = c
    elsif c = Category.find_by_id(cat)
      client.category = c
    else
      c = Category.create(name: cat)
      client.category = c
    end
    last_10 client
  end

  def last_10(client)
    History.where(:category_id => client.category.id).last(10).each do |hist|
      client.connection.puts hist.content
    end
  end

end
