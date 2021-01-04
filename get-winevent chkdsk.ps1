# Event Viewer chkdsk results
get-winevent -FilterHashTable @{logname = "Application"; id = "1001" } | ? { $_.providername –match "wininit" } | fl timecreated, message

# get-winevent -FilterHashTable @{logname = "Application"; id = "1001" } | ? { $_.providername –match "wininit" } | fl timecreated, message | out-file c:\CHKDSKResults.txt