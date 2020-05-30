#!/bin/bash
python parse.py > ~tmp
gnuplot <<-EOFMarker
    set terminal pdf enhanced font 'Verdana,10'
    set output 'graph.pdf'
    set title "Write/read performance during badblocks" font ",14" textcolor rgbcolor "royalblue"
    set xlabel "Time"
    set ylabel "MB/s"
    set ytics nomirror
    set y2tics nomirror
    #set xdata time
    set pointsize 0
    set yrange [0:220]
    set y2range [0:60]
    plot "~tmp" using 1:2 with lines title "read" , \
         "~tmp" using 1:3 with lines title "write", \
         "~tmp" using 1:4 with lines title "temp" axes x1y2
EOFMarker
