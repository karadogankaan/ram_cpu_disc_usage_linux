#!/bin/bash

# 60 saniye boyunca ram, cpu ve disk miktari kontrolu | Control of ram, cpu and disk amount for 60 seconds

total_cpu=$(nproc) # Toplam CPU miktarini verir. | Returns the total amount of CPU.

total_ram=$(free -m | awk 'NR==2{print $2}') # Toplam RAM miktarini verir. | Returns the total amount of RAM.

total_disk=$(df -h / | awk 'NR==2{print $2}') # Toplam disk miktarini verir. | Returns the total disk amount.

for ((i=0; i<60; i++)) # Programin 60 saniye boyunca tekrarlanacagi anlamina gelir. | It means that the program will repeat for 60 seconds.
do
    used_cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}') # Suan aktif kullanılan CPU miktarini verir. | It now gives the amount of CPU actively used.

    used_ram=$(free -m | awk 'NR==2{print $3}') # Suan aktif kullanilan RAM miktarini verir. | It gives the amount of RAM currently used.

    used_disk=$(df -h / | awk 'NR==2{print $3}') # Suan aktif kullanilan DISK miktarini verir. | It gives the amount of DISK currently used.

    cpu_percentage=$(awk "BEGIN{printf \"%.1f\", $used_cpu / $total_cpu * 100}") # CPU'nun yuzdelik hesabi (float)(.2f - .3f ile yuzdelik kisim azaltilabilir.) | Percentage calculation of the CPU (float)(The percentile can be reduced with .2f - .3f.)

    ram_percentage=$(awk "BEGIN{printf \"%.2f\", $used_ram / $total_ram * 100}") # RAM'in yuzdelik hesabi (float)(.2f - .3f ile yuzdelik kisim azaltilabilir.) | Percentage calculation of RAM (float)(The percentile can be reduced with .2f - .3f.)

    disk_percentage=$(awk "BEGIN{printf \"%.2c\", $used_disk / $total_disk *100 }") # DISK'in yuzdelik hesabi (float)(.2f - .3f ile yuzdelik kisim azaltilabilir.) | Percentage calculation of DISK (float)(Percentage can be decreased with .2f - .3f.)

    echo "Saniye: $((i+1))"  # Sayac 60 saniye  boyunca her saniye resetlenerek hesaplamasi icin ayarlanmistir. | The counter is set to be calculated by resetting every second for 60 seconds.
    echo "CPU Kullanimi: [%$cpu_percentage] $used_cpu / $total_cpu "  # Kullanilan CPU / Toplam CPU | CPU Used / Total CPU
    echo "RAM Kullanimi: [%$ram_percentage] $used_ram / $total_ram "  # Kullanilan RAM / Toplam RAM  | Used RAM / Total RAM
    echo "DISK Kullanimi: [%$disk_percentage] $used_disk / $total_disk "  # Kullanilan DISK / Toplam DISK  | Kullanilan DISK / Toplam DISK 

    sleep 1
    
done