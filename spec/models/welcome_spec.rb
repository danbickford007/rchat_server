require 'spec_helper'

describe Welcome do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
  end
 
  let(:connection) { TCPSocket.new('localhost', 6667) }
  let(:client) { Client.new() }  
  let(:welcome) { Welcome.new(connection, client) }

  describe '#greet' do
    it 'client should exist' do
      connection.should_not be_nil
    end

    it 'should greet client' do
      connection.should_receive(:puts)
      welcome.stub(:login)
      welcome.greet
    end
  end

end
