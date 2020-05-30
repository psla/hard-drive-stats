#!/bin/bash
python parse.py > ~tmp
gnuplot <<-EOFMarker
    set terminal pdf enhanced font 'Verdana,10'
    set output 'graph.pdf'
    set title "Write/read performance during badblocks" font ",14" textcolor rgbcolor "royalblue"
    set xlabel "Time"
    set ylabel "MB/s"
    set xdata time
    set pointsize 1
    plot "~tmp" using 0:1 with linespoints title "read", \
         "~tmp" using 0:2 with linespoints title "write", \
         "~tmp" using 0:3 with linespoints title "temp"
EOFMarker
