require 'spec_helper'

describe Command do
  
  before do
      @server = TCPServer.new 6667
  end

  after do
      @server.close
  end
 
  let(:connection) { TCPSocket.new('localhost', 6667) }
  let(:client) { Client.new } 
  let(:command) { Command.new(connection) }

  describe '#check' do

    it 'should return true if command' do
      command.is_command(':test').should == true
    end
    
    it 'return false if not command' do
      command.is_command('test').should == false
    end

  end

  describe '#issue' do

    it 'should call category create when :category:test' do
      Category.any_instance.should_receive(:set)
      command.issue(client, ':category:test')
    end

  end

end
