Class DrupalSettings {
  [string]$PhpExecutable = 'php';
}

$global:DrupalSettings = [DrupalSettings]::new()