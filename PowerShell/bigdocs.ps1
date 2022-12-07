param ([String]$Path=".", [long]$MinimumSize = 0)

This example will show a gridview listing of large document files in a folder specified by the user, having a minimum size specified by the user, with both parameters available to use from the command line
It shows the script having 2 parameters, and a function with one parameter
function Get-Docs
    Get-ChildItem
([string]$DocsPath=".") {

-Path $DocsPath 

-Include *.txt,*.doc,*.docx,*.pdf,*.xls,*.ppt,*.ps1 
 -Recurse 

-ErrorAction SilentlyContinue

}

Get-Docs -DocsPath $path |

Where-Object { $_.length -ge $minimumsize } |
 Select-Object FullName, LastAccessTime, Length |
 Sort-Object -Descending Length |

Out-GridView