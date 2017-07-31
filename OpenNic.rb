#!/usr/bin/env ruby

class Opennic
	
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
	

end


test = Opennic.new
test.resolvconf		
