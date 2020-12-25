require 'socket'
require 'openssl'
require 'json'

host = ENV["IP_ADDRESS"]
port = ENV["LOGSTASH_PORT"]

socket = TCPSocket.open(host,port)

ssl_context = OpenSSL::SSL::SSLContext.new()

puts ENV['LOGSTASH_PATH']

ssl_context.cert = OpenSSL::X509::Certificate.new(File.open("#{ENV['LOGSTASH_PATH']}/ssl_certificates/host/host.crt"))

ssl_context.ca_file = "#{ENV['LOGSTASH_PATH']}/ssl_certificates/ca/ca.crt"

ssl_context.key = OpenSSL::PKey::RSA.new(File.open("#{ENV['LOGSTASH_PATH']}/ssl_certificates/host/host.key"))

ssl_context.verify_mode = OpenSSL::SSL::VERIFY_PEER
ssl_context.ssl_version = :SSLv23
ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
ssl_socket.sync_close = true
ssl_socket.connect

ssl_socket.puts(JSON.generate(message: "hello"))
while line = ssl_socket.gets
  p line
end
ssl_socket.close

