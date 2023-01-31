#! /usr/bin/bash
usage=$(df -m |grep "dev/sda3" |
	awk '{us+=$3}
	END {if(us>=1024) us=us/1024}
	END {printf("%.1f", us)}'
	)
tot_mem_size=$(df -m | grep "/dev/sda3" | 
	awk '{tot+=$2}
	END {if(tot>=1024) printf("%.1fGb", tot=tot/1024)
		else printf("%.0fMB", tot)}'
	)
memory_percent=$(df -m | grep "dev/sda3" |
	awk '{usage+=$3; total+=$2}
	END {printf("%.2f", usage/total*100)}'
	)

wall "
Architecture: $(uname -a)
CPU physical: $(lscpu | grep "Socket(s):" | awk '{print $2}')
vCPU: $(nproc --all)
Memory Usage: $(free -m | grep "Mem:" | awk '{printf($3"/"$2"Mb ""(%.2f%)"), $3/$2*100}')
Disk Usage: $usage/$tot_mem_size ($memory_percent%)
CPU load: $(top -b -n 1 | awk 'NR>7 {cpu=cpu+$9} END {printf("%.1f%%", cpu)}')
Last boot: $(who -b | awk '{print $3 " " $4}')
"
