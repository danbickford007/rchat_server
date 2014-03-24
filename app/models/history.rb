class History < ActiveRecord::Base

  attr_accessor :client, :connection

  def show_by_category
    category = Category.new
    category.set_connection(client.connection, connection)
    client.connection.puts 'Choose a category id to view history:'
    category.show_all
    cat = client.connection.gets.chomp
    History.where(:category_id => cat).each do |hist|
      client.connection.puts hist.content
    end
  end

end
