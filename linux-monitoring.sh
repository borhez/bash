#! /usr/bin/bash


wall "
Architecture: $(uname -a)
CPU physical: $(lscpu | grep "Socket(s):" | awk '{print $2}')
vCPU: $(nproc --all)
Memory Usage: $(free -m | grep "Mem:" | awk '{printf($3"/"$2"Mb ""(%.2f%)"), $3/$2*100}')
"
