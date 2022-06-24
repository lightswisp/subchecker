require "socket"

threads = []

filename, workers = ARGV

if !filename || !filename.include?(".txt") || !workers || !File.exist?(filename)
 puts "="*60
 puts "[ SUBCH3CKER ]"
 puts "Usage: ruby subchecker.rb <filename.txt> <threads>"
 puts "="*60
 #return
  filename = "domains.txt"
  workers  = 10
end


workers = workers.to_i
urls = File.readlines(filename)
urls.map! {|line| line.chomp}
mutex = Mutex.new
responses = []

workers.times do
 threads << Thread.new(urls) do |j|
   while url = mutex.synchronize{j.pop}

begin

socket = Socket.new( Socket::AF_INET, Socket::SOCK_STREAM, 0)
addr_info = Socket.getaddrinfo(url, "http", nil, :STREAM)
ip     = addr_info[0][0] == "AF_INET6" ? addr_info[1][3] : addr_info[0][3]
connection = socket.connect(Socket.sockaddr_in( 80, ip ))

if connection == 0
 puts "[ + ] #{url}"
end
 
rescue 

end
end
   
  end
 end
 
threads.each {|thread| thread.join}
