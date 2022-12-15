#lab4 - sysinfo.ps1
# 
#Include the system hardware description (win32_computersystem)
#
"Hardware Report:"
get-ciminstance win32_computersystem |format-table -autosize description
#
#
#Include the operating system name and version number (win32_operatingsystem)
#
"Operating System Report:"
get-ciminstance win32_operatingsystem |format-table -autosize name, version
#
#
#Include processor description with speed, number of cores, and sizes of the L1, L2, and L3 caches if they are present (win32_processor)
#
"Processor Report:"
get-ciminstance win32_processor |format-table -autosize description, CurrentClockSpeed, NumberOfCores, L1CacheSize, L2CacheSize, L3CacheSize
#
#
#Include a summary of the RAM installed with the vendor, description, size, and bank and slot for each DIMM as a table and the total RAM installed in the computer as a summary line after the table (win32_physicalmemory)
#
"RAM Report:"
get-ciminstance win32_physicalmemory | format-table -autosize manufacturer, description, capacity, BankLabel, TotalWidth
#
#
"Physical Memory Report"
$diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               }
           }
      }
  }
#
#
#Include your network adapter configuration report from lab 3
#
"IP config Report:"
ipconfigreport
#
#
#
#include the video card vendor, description, and current screen resolution in this format: horizontalpixels x verticalpixels (win32_videocontroller)
#
"Video Card Report:"
get-ciminstance win32_videocontroller | format-table -autosize description, CurrentHorizontalResolution, CurrentVerticalResolution

