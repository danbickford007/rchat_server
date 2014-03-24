task :server => :environment do 
  begin
    server = Server.new('', 3000)
  rescue => e
    p 'ERROR !!!!!!!!!!!!!!!!'
    p e
    p e.backtrace
  end
end

