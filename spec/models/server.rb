require 'spec_helper'

describe Server do

  describe '.new' do

    before do
       @server = TCPServer.open 6667
       @client_ser = TCPServer.open 6667
       @client_ser.gets
       @client = @server.accept
    end

    after do
        @server.close
    end



    it 'should create TCP server' do
      expect (@client).to eq(nil)
    end

  end

end
