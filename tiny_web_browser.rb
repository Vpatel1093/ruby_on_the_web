require 'socket'
require 'json'

host = 'localhost'
port = 2000

puts "Welcome to the mini web browser. Please select one of the following options. \n1. GET\n2. POST"
selection = gets.chomp
																																																																																																																										
if selection == "1"
	path = "/index.html"
	request = "GET #{path} HTTP/1.0\r\n\r\n"
elsif selection == "2"
	path = "/thanks.html"
	puts "In order to register for the viking raid, enter your name:"
	name = gets.chomp
	puts "Enter your email address as well:"
	email = gets.chomp
	
	viking_hash = {:viking => {:name => name, :email => email}}.to_json
	request = "POST #{path} HTTP/1.0\r\nFrom: #{email}\r\nUser-Agent: WebBrowser\r\nContent-Type: application/json\r\nContent-Length: #{viking_hash.to_s.length}\r\n\r\n#{viking_hash}"	
else
	puts "Invalid selection"
	exit
end
	
socket = TCPSocket.open(host,port)
socket.print(request)
response = socket.read
header,body = response.split("\r\n\r\n",2)
print body
socket.close
