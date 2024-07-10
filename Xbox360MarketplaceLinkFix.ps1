# Xbox 360 Marketplace links are broken in-browser.
# Run script, enter marketplace link. If prompted to sign in, do so then run script again.
# https://marketplace.xbox.com/en-US/Product/Halo-Reach/66acd000-77fe-1000-9115-d8024d53085b?DownloadType=GameVideo#LiveZone

$marketplacelink = Read-Host "Enter marketplace link and will launch correct site in default browser."

# Purchase link listed in HTML source.
$x = (Invoke-WebRequest -Uri $marketplacelink).Links.'data-purchaseurl' -split "\\r?\\n" | Select-String -NotMatch ^$
# Open link without broken query string.
$x | ForEach-Object { Start-Process ($_ -split "\?")[0] }

Pause
