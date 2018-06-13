Class Drupal {
  [string]findRoot($start_path) {
    $path = get-item $start_path;

    # Traverse up the directory structure until we find
    # a valid drupal root, or we hit the system root.
    do {
      $valid = $this.isValidPath($path);

      if ($valid) {
        return $path.FullName;
      }

      $path = $path.Parent
    } while($path);

    return $null;
  }

  [bool]isValidPath($path) {
    $check_path = $path.FullName;
    $valid = (Test-Path "$check_path/web") -and (Test-Path "$check_path/composer.json") -and (Test-path "$check_path/vendor/drush");
    return $valid;
  }

  [string]findDrush($root) {
    if ($root) {
      if(test-path "$root/vendor/drush/drush/drush") {
        return "$root/vendor/drush/drush/drush"
      }
    }
    return $null;
  }

  [string]findDrupalConsole($root) {
    if ($root) {
      if(test-path "$root/vendor/drupal/console/bin/drupal") {
        return "$root/vendor/drupal/console/bin/drupal"
      }
    }
    return $null;
  }
}