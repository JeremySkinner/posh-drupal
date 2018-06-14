. $PSScriptRoot\DrupalSettings.ps1
. $PSScriptRoot\DrupalFinder.ps1

function New-Drupal() {
  return [Drupal]::new();
}
function drush() {
  $path = Get-Location
  $drupal = New-Drupal
  $root = $drupal.findRoot($path);
  $drush = $drupal.findDrush($root);

  if ($drush) {
    # Make sure we run drush in the web directory
    Push-Location "$root/web"
    & $global:DrupalSettings.PhpExecutable $drush $args;
    Pop-Location
  }
  else {
    Write-Output "Could not find drush."
  }
}

function drupal() {
  $path = Get-Location
  $drupal = New-Drupal
  $root = $drupal.findRoot($path);
  $console = $drupal.findDrupalConsole($root);

  if ($console) {
    # Make sure we run console in the web directory
    Push-Location "$root/web"
    & $global:DrupalSettings.PhpExecutable $console $args;
    Pop-Location
  }
  else {
    Write-Output "Could not find drupal console."
  }
}

Export-ModuleMember -Function New-Drupal, drush, drupal
