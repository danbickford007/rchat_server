require 'spec_helper'

describe Login do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
  end
 
  let(:connection) { TCPSocket.new('localhost', 6667) }
  let!(:client) { Client.create(email: 'test@test.com', password:'1234') } 
  let(:login) { Login.new(connection) }

  describe '#start' do

    it 'should proceed with correct email' do
      connection.should_receive(:gets).exactly(1).times.and_return(client.email)
      login.should_receive(:proceed)
      login.start 
    end
    
    it 'should NOT proceed with incorrect email' do
      connection.should_receive(:gets).exactly(1).times.and_return('badness')
      login.should_receive(:create)
      login.start 
    end

  end

  describe '#proceed' do

    it 'should proceed with matching password' do
      connection.should_receive(:puts).with('Enter password:')
      connection.should_receive(:gets).exactly(1).times.and_return('1234')
      connection.should_receive(:puts).with('successfully logged in ...')
      login.proceed client
    end

  end

end
