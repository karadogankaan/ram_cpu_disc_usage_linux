#!/bin/bash

# Control of ram, cpu and disk amount for 60 seconds

total_cpu=$(nproc) # Returns the total amount of CPU.

total_ram=$(free -m | awk 'NR==2{print $2}') # Returns the total amount of RAM.

total_disk=$(df -h / | awk 'NR==2{print $2}') # Returns the total disk amount.

for ((i=0; i<60; i++)) # It means that the program will repeat for 60 seconds.
do
    used_cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}') # It now gives the amount of CPU actively used.

    used_ram=$(free -m | awk 'NR==2{print $3}') # It gives the amount of RAM currently used.

    used_disk=$(df -h / | awk 'NR==2{print $3}') # It gives the amount of DISK currently used.

    cpu_percentage=$(awk "BEGIN{printf \"%.1f\", $used_cpu / $total_cpu * 100}") # Percentage calculation of the CPU (float)(The percentile can be reduced with .2f - .3f.)

    ram_percentage=$(awk "BEGIN{printf \"%.2f\", $used_ram / $total_ram * 100}") # Percentage calculation of RAM (float)(The percentile can be reduced with .2f - .3f.)

    disk_percentage=$(awk "BEGIN{printf \"%.2c\", $used_disk / $total_disk *100 }") # Percentage calculation of DISK (float)(Percentage can be decreased with .2f - .3f.)

    echo "Saniye: $((i+1))"  # The counter is set to be calculated by resetting every second for 60 seconds.
    echo "CPU Kullanimi: [%$cpu_percentage] $used_cpu / $total_cpu "  # CPU Used / Total CPU
    echo "RAM Kullanimi: [%$ram_percentage] $used_ram / $total_ram "  # Used RAM / Total RAM
    echo "DISK Kullanimi: [%$disk_percentage] $used_disk / $total_disk "  # Kullanilan DISK / Toplam DISK 

    sleep 1
    
done
