#!/bin/bash
declare -a browser_process
declare -a browser_cpu
cpu_ideal=11.0;
browser_process=( $(ps -aux | grep chromium-browser |  tr -s ' ' | cut -d ' ' -f 2) )
for i in "${browser_process[@]}"
  do
    browser_cpu=( $(ps -p "$i" -o %cpu | tail -n +2) )
    for j in "${browser_cpu[@]}"
     do
      if [$j -gt $cpu_ideal]; then
       echo "$j"
      # cpulimit -p "$i" -l 11
      # break
      fi
    done
     #echo "${browser_cpu[@]}"
 done


