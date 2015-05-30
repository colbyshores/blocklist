require 'net/smtp'
require 'resolv'
require 'time'

def sendnotifications(ipaddresses, list)
  recipients = ["infosecfoo@companyfoo.com"] #array of emails to send to
  mailuser = 'noc@companyfoo.com' #email of the companys noc/admin email
  mailsmtp = 'xxx.xxx.xxx.xxx' #smtp server of the primary mail server
  Net::SMTP.start(mailsmtp, 25) do |smtp|
    message = ''
    message = <<EOF
From: Noc <#{mailuser}>
To: #{recipients.join(", ")}
Subject: IP #{ipaddresses} blacklisted on #{list}!

#{ipaddresses} is blacklisted on #{list}
EOF
smtp.send_message(message, mailuser, recipients)
  end
end
  
def night_time?(t)
  t.hour > 22 || t.hour < 8 #only notify between 8 and 11 pm
end

def blocklists(ip)
    lists = File.readlines("#{File.expand_path(File.dirname(__FILE__))}/conf/blocklist.conf")
    raise ArgumentError, "You must specify an IP address to check" if !ip
      ip = ip.chomp
      raise ArgumentError, "Invalid IP specified" if !ip.match(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)
      check = ip.split('.').reverse.join('.') #reverse the ip address to conform to CBL list format.
      listed = []
      lists.each do |list|
        begin
          host = check+'.'+list[0..-2]
          Resolv::getaddress("#{host}"[0..-2])
          listed << list
        rescue Exception => e
          case e
            when Interrupt
              exit 0
          else
        end
      end
    end
    if listed.size > 0
      return listed
    end
end

listed = []
watchlist = File.readlines("#{File.expand_path(File.dirname(__FILE__))}/conf/iplist.conf")
threads = []
watchlist.each do |ipaddresses|
  threads <<  Thread.new {
    while true
      if not night_time?(Time.now)
        listed = blocklists(ipaddresses)
        if listed
           listed.each do |item|
             sendnotifications(ipaddresses[0..-2],item)
           end
        end
      end
      listed.clear
      sleep(3600) #check once an hour, 3600 seconds being 1 hour.
    end
  }
end
threads.each { |thr| thr.join }
