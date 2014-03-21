task :server => :environment do 
  server = Server.new('', 3000)
end

