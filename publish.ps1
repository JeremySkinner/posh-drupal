$keyfile = "$env:USERPROFILE\Dropbox\powershellgallery-access-key.txt"

if(-not (test-path $keyfile)) {
  throw "Could not find the NuGet access key at $keyfile."
}

$key = get-content $keyfile

write-host Publishing...
Publish-Module -Name "./posh-drupal.psm1" -NuGetApiKey $key
write-host Done.