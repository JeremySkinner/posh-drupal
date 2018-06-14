# posh-drupal
This project provides Powershell commands for working with the Drupal 8 CLI (drush and the drupal console).

Currently this project exposes 2 commands `drush` and `drupal` which invoke drush and the drupal console respectively. These commands will search the working directory hierarchy to find the drush and drupal console scripts, in a similar way to how [drush launcher](https://github.com/drush-ops/drush-launcher) works.

This requires that Drupal 8 has been installed using Composer.

## Installation

To get started, install the `posh-drupal` module from the Powershell Gallery:

`install-module posh-drupal`

Once installed, import the module (you can add this in your Powershell profile):

`import-module posh-drupal`

The following commands will now be available in your shell:

```powershell
drush
drupal
New-Drupal
```

Note that the New-Drupal function just returns an instance of the `Drupal` class which encapsulates the logic for finding a drupal installation in a directory's hierarchy. It is used internally by the `drush` and `drupal` functions.

## Customization

These commands assume that the `php` executable is available in your path. If you want to force use of a specific PHP executable, then add the following to your profile:

```powershell
$global:DrupalSettings.PhpExecutable = 'C:\PHP72\php.exe'
```