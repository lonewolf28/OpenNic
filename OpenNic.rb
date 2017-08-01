#!/usr/bin/env ruby

class Opennic
	require 'uri'
	require 'net/fping'
	
	def initialize
		@urls = []
		@resolv_file = '/etc/resolvconf/resolv.conf.d/head'
		@head_ip = []
	end
	
	def resolvconf
		require 'uri'
		file_content = IO.read(@resolv_file)
		file_content.split("\n").each do |line|
			if not line.start_with?("#")
				@head_ip.push(line.split("\n")[1])
			end
		end
	end
	
	private
		def pingfn(host)
			result = ""
			#check if fping is installed
			if File.exists(`which fping`.chomp)
				result = %x{fping -q -p 20 -r 0 -c 25 #{host}}
			else
			#Fallback to normal ping
				result = %x{ping -q -i 0.5 -c 10 #{host}}
			end
			result
		end
end


test = Opennic.new
test.resolvconf		
