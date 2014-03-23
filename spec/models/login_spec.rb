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
  let(:login) { Login.new(connection, client) }

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

  describe '#create' do
    it 'should call create_client if continuing' do
      connection.should_receive(:puts).with('Email does not exist, do you want to create this account?(y/n)')
      connection.should_receive(:gets).exactly(1).times.and_return('y')
      login.should_receive(:create_client)
      login.create client.email
    end
    it 'should call exit if no' do
      connection.should_receive(:puts).with('Email does not exist, do you want to create this account?(y/n)')
      connection.should_receive(:gets).exactly(1).times.and_return('n')
      connection.should_receive(:puts).with('DISCONNECTING ...')
      login.create client.email
    end
  end

  describe '#create_client' do

    it 'should set client object email' do
      connection.should_receive(:puts).with('Please enter a password, remember this:')
      connection.should_receive(:gets).exactly(1).times.and_return('1234')
      connection.should_receive(:puts).with('sucessfully created account')
      login.create_client 'test@user.com'
      login.client.email.should == 'test@user.com'
    end

    it 'should create a client record' do
      connection.should_receive(:puts).with('Please enter a password, remember this:')
      connection.should_receive(:gets).exactly(1).times.and_return('1234')
      connection.should_receive(:puts).with('sucessfully created account')
      Client.should_receive(:create).and_return(client)
      login.create_client 'test@user.com'
    end

  end

end
