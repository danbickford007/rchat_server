require 'spec_helper'

describe Category do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
  end
 
  let(:connection) { TCPSocket.new('localhost', 6667) }
  let(:client) { Client.new } 
  let(:category) { Category.new }

  before(:all) do 
    Category.destroy_all
    Category.create(name: 'Ruby')
  end

  describe '#show_all' do

    it 'should show all categories to client' do
      connection.should_receive(:puts).with("#{Category.first.id}: Ruby")
      category.set_connection connection, client
      category.show_all     
    end

  end

  describe '#get_choice' do
    it 'should get client input' do
      category.set_connection connection, client
      connection.should_receive(:gets).and_return(Category.first.id.to_s)
      category.get_choice
    end

    it 'should respond choice to client if found' do
      category.set_connection connection, client
      connection.should_receive(:gets).and_return(Category.first.id.to_s)
      connection.should_receive(:puts)
      category.get_choice
    end
  end

end
