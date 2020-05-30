import re
file = open('wd-elements-12TB-WD120EMAZ.stats.txt', 'r')
lines = file.readlines()

first_time_nanos=-1
previous_time_nanos=-1
for line in lines:
  match = re.search('Sector.*\s(\d+) bytes / \d+ bytes', line)
  if match:
    sector_size = int(match.group(1))
  if line[0] == '1':
    splitline = line.split(' ')
    timestamp_nanos = long(splitline[0])
    temperature = int(splitline[10])
    # vmstat -d :
#    # FIELD DESCRIPTION FOR DISK MODE
#   Reads
#       total: Total reads completed successfully
#       merged: grouped reads (resulting in one I/O)
#       sectors: Sectors read successfully
#       ms: milliseconds spent reading
#
#   Writes
#       total: Total writes completed successfully
#       merged: grouped writes (resulting in one I/O)
#       sectors: Sectors written successfully
#       ms: milliseconds spent writing
#
#   IO
#       cur: I/O in progress
#       s: seconds spent for I/O

    sectors_read = long(splitline[16])
    sectors_written = long(splitline[20])
    
    if previous_time_nanos != -1:
      delta_time_nanos = timestamp_nanos - previous_time_nanos    
      bytes_written = (sectors_written - previous_sectors_written) * sector_size
      bytes_read = (sectors_read - previous_sectors_read) * sector_size
      normalized_timestamp_seconds = (timestamp_nanos - first_time_nanos) / 1000000000.1
      delta_seconds = (timestamp_nanos - previous_time_nanos) / 1000000000.1
      print("%.2f\t%.2f\t%.2f\t%d" % (normalized_timestamp_seconds, bytes_read/delta_seconds/1024.0/1024.0, bytes_written/delta_seconds/1024.0/1024.0, temperature))
    else:
      first_time_nanos = timestamp_nanos
    previous_time_nanos = timestamp_nanos
    previous_sectors_written = sectors_written
    previous_sectors_read = sectors_read

