#Ip config report
#
#Produce a report showing the ip configuration for the computer.
#
#
#Split into 2 parts to fit on screen
#
#
function part1 {get-ciminstance win32_networkadapterconfiguration | where-object ipenabled |format-table -autosize description, index, ipaddress}
#
#Call funtion part 1
#
part1
#
#Call funtion part 2
#
function part2 {get-ciminstance win32_networkadapterconfiguration | where-object ipenabled |format-table -autosize ipsubnet, dnsdomain, dnsserversearchorder}
part2