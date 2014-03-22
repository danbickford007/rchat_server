class Client < ActiveRecord::Base

  attr_accessor :connection, :category

  def initialize
  end

  def set_connection(connection)
    @connection = connection
  end
end
