require 'spec_helper'

describe History do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
  end
 
  let(:connection) { TCPSocket.new('localhost', 6667) }
  let(:client) { Client.new } 

  describe '#set' do

  end

end
