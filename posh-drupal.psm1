. $PSScriptRoot\DrupalSettings.ps1
. $PSScriptRoot\DrupalFinder.ps1

$script:OriginalPath = "";

function New-Drupal() {
  return [Drupal]::new();
}
function drush() {
  $path = Get-Location
  $drupal = New-Drupal
  $root = $drupal.findRoot($path);
  $drush = $drupal.findDrush($root);

  if ($drush) {
    Set-EnvironmentVariables
    # Make sure we run drush in the web directory
    & $global:DrupalSettings.PhpExecutable $drush --root="$root/web" $args;
    Reset-EnvironmentVariables
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
    Set-EnvironmentVariables
    # Make sure we run console in the web directory
    & $global:DrupalSettings.PhpExecutable $console --root="$root/web" $args;
    Reset-EnvironmentVariables
  }
  else {
    Write-Output "Could not find drupal console."
  }
}

function Set-EnvironmentVariables {
  # Get executable path
  $php_path = Get-Command $global:DrupalSettings.PhpExecutable -ErrorAction Ignore

  if($php_path) {
    $php_path = $php_path.Path
    $php_path = (get-item $php_path).DirectoryName

    # Cache original path
    $script:OriginalPath = $Env:Path
    # Append path to PATH
    $Env:PATH += ";$php_path"
  }
}

function Reset-EnvironmentVariables {
  if($script:OriginalPath) {
    $Env:PATH = $script:OriginalPath
    $script:OriginalPath = $null
  }
}

Export-ModuleMember -Function New-Drupal, drush, drupal
