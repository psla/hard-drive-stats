#!/bin/bash
drive=sdg
fdisk -l /dev/$drive
while [ true ]
do
  # note that the date here is approximate: smartctl and vmstat have variance in how long they take. So over time, the average
  # is going to be correct -- but for a single data point this is just an approximation!
  echo `date +%s%N` `smartctl -a /dev/$drive | grep -i temperat` `vmstat -d | grep $drive`
  sleep 5
done
