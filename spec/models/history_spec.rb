require 'spec_helper'

describe History do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
      History.destroy_all
  end
 
  let(:connection) { TCPSocket.new('localhost', 6667) }
  let(:client) { Client.new }
  let(:history) { History.new } 
  let(:category) { Category.new }

  before(:each) do
    client.connection = connection
    history.client = client
    category.set_connection connection, client
    hist1 = History.create(content: 'test', category_id: Category.first.id)
  end

  describe '#show_by_category' do

    it 'should puts relevant history for category to client' do
      connection.should_receive(:puts).with("Choose a category id to view history:")
      Category.any_instance.stub(:show_all)
      connection.should_receive(:gets).and_return(Category.first.id.to_s)
      connection.should_receive(:puts).exactly(1).times
      history.show_by_category
    end

  end

end
