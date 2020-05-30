#!/bin/bash
python parse.py > ~tmp
gnuplot <<-EOFMarker
    set terminal pngcairo size 350,262 enhanced font 'Verdana,10'
    set output 'graph.png'
    set title "Write/read performance during badblocks" font ",14" textcolor rgbcolor "royalblue"
    set xlabel "Time"
    set ylabel "MB/s"
    set timefmt "%y/%m/%d"
    set xdata time
    set pointsize 1
    plot "~tmp" using 0:1 with linespoints
    plot "~tmp" using 0:2 with linespoints
    plot "~tmp" using 0:3 with linespoints
EOFMarker
