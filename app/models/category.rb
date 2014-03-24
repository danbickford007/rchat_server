class Category < ActiveRecord::Base

  attr_accessor :connection

  def set_connection connection
    @connection = connection
  end

  def show_all
    categories = Category.all
    cats = []
    categories.each do |cat|
      cats << "#{cat.id}: #{cat.name}"
    end
    @connection.puts cats.join("\n")
  end

  def get_choice
    msg = @connection.gets.chomp
    cat = Category.find_by_id(msg)
    if cat
      @connection.puts "Now in category #{cat.name}"
      cat
    else
      show_all
      get_choice
    end
  end

end
