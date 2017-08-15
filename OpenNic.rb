#!/home/xtra/.rvm/rubies/ruby-2.4.1/bin/ruby


def get_opennic_ips
	require 'open-uri'
	url_addr = 'https://api.opennicproject.org/geoip/?list&lat=43.6&lon=-79.3&pct=90&res=5'
	open(url_addr) do |web|
		web.each_line do |line|
			yield line
		end
	end
end

def write_ips
	file_loc = '/etc/resolvconf/resolv.conf.d/head'
	file_loc2 = '/etc/resolv.conf'
	wh = File.open(file_loc, 'w')
	wh2 = File.Open(file_loc2, 'w')
	banner =<<-EOF
	#This was generated by Ruby script on #{Time.now}
	EOF
	wh.write(banner)
	get_opennic_ips do | ips |
		wh.write("nameserver" + " " + ips )
		wh2.write("nameserver" + " " + ips )
	end
	wh.close
	wh2.close
end

write_ips