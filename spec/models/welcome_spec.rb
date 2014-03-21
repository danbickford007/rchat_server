require 'spec_helper'

describe Welcome do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
  end
  
  let(:client) { TCPSocket.new('localhost', 6667) }
  let(:welcome) { Welcome.new(client) }

  describe '#greet' do
    it 'client should exist' do
      client.should_not be_nil
    end

    it 'should greet client' do
      client.should_receive(:puts)
      welcome.greet
    end
  end

end
