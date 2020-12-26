require 'socket'
require 'openssl'
require 'json'
require 'active_support/all'

def get_machine_ip
	ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
	ip.ip_address
end

def get_logstash_ip
	machine_ip = get_machine_ip
	return ENV["IP_ADDRESS"] unless ENV["IP_ADDRESS"].nil?

	unless ENV["IP_ADDRESSES"].blank?
		ENV["IP_ADDRESSES"].split(",").each do |ip|
			if machine_ip == ip
				return ip
			end
		end
	end
	return "0.0.0.0"
end	

port = ENV["LOGSTASH_PORT"]

socket = TCPSocket.open(get_logstash_ip,port)

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

