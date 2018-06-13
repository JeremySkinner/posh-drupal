Import-Module $PSScriptRoot\..\posh-drupal.psm1
Describe 'drupal CLI powershell integration' {

  $drupal = New-Drupal

  It 'Finds the drupal 8 root when already in the root' {
    $root = $drupal.findRoot("$PSScriptRoot\d8-root")
    $root | should -Not -Be $null
  }

  It 'Finds the drupal 8 root when in a subdirectory' {
    $root = $drupal.findRoot("$PSScriptRoot\d8-root\web\vendor")
    $root | should -Not -Be $null
  }

  It "Doesn't find the drupal 8 root when inside a non-drupal directory" {
    $root = $drupal.findRoot("$PSScriptRoot\empty")
    $root | should -BeNullOrEmpty
  }

  It "Invokes drush" {
    $output = (drush "$PSScriptRoot\d8-root\web") | out-string
    $output.Trim() | Should -Be "drush"
  }

  It "Invokes drupal console" {
    $output = (drupal "$PSScriptRoot\d8-root\web") | out-string
    $output.Trim() | Should -Be "drupal"
  }

  It "Doesn't launch drush if not found" {
    $output = (drush "$PSScriptRoot\empty") | out-string
    $output.Trim() | Should -Be "Could not find drush."
  }

  It "Doesn't launch drupal if not found" {
    $output = (drupal "$PSScriptRoot\empty") | out-string
    $output.Trim() | Should -Be "Could not find drupal console."
  }

}