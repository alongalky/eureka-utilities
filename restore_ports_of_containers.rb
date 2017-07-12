#!/usr/bin/ruby

comb = `echo 'SELECT container_id,ssh_port from machines' | mysql -h 127.0.0.1 -P 3306 -u roboto --password=tHMu4ZXuMJHuT8hFccEZVmZ6 eureka_beta | tail -n+2`

pairs = comb.split("\n")

pairs.each do |pair|
  container, port = pair.split("\t")
  puts "Stopping container #{container}"
  system("docker stop #{container}")
end

system('systemctl stop docker')

pairs.each do |pair|
  container, port = pair.split("\t")
  puts "Altering container #{container} with port #{port}"
  system("cd /var/lib/docker/containers/#{container}* && sed -ri 's/\"HostPort\":\"[^\"]+?\"/\"HostPort\":\"#{port}\"/\' hostconfig.json")
end

system('systemctl start docker')

pairs.each do |pair|
  container, port = pair.split("\t")
  puts "Starting container #{container}"
  system("docker start #{container}")
end
  

