# Overview

This set of scripts allows to gather performance & temperature data when running operations on disk. For example, I chose to run this when running `badblocks -wsv /dev/my-disk -b 4096`.

## Preparation

You must run (in screen/tmux) `stats.sh`. 

1. modify stats.sh 'drive' to use your drive name (yeah, yeah, should be a parameter)
1. run `./stats.sh | tee stats-output-file` for however long you want

## Run you command

```
badblocks -wsv /dev/sdg -b 4096
```

## Draw graph

1. Modify the filename with your stats in `parse.py`.
1. Run `./plot.sh`

Enjoy
