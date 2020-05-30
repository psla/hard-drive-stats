#!/bin/bash
drive=sdg
fdisk -l /dev/$drive
while [ true ]
do
  echo `date +%s%N` `smartctl -a /dev/$drive | grep -i temperat` `vmstat -d | grep $drive`
  sleep 5
done
