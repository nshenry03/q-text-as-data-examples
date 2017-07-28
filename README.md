# q-text-as-data-examples

With [q](https://github.com/harelba/q), it's easy to run quick and simple
queries agains text files or you can build complicated reports.

## Quick and dirty command line example

This query shows all of the versions of WordPress that were supported:

    q -H -d, "SELECT application_versions.version FROM ./Application.csv applications JOIN ./ApplicationVersion.csv application_versions ON (application_versions.application_id = applications.id) WHERE applications.title = 'WordPress' ORDER BY application_versions.version"

## Sample Report

This is an example of a full report that accepts user input:

### `./reports/count_versions.sh -c30`

    application,count
    Drupal,35
    Joomla,34
    WordPress,30

### `./reports/count_versions.sh --count=10`

    application,count
    Drupal,35
    Joomla,34
    WordPress,30
    SetSeed,22
    OpenVBX,19
    SugarCRM,18
    MuraCMS,14
    phpMyAdmin,11
    Magento,10
    ownCloud,10

### `./reports/count_versions.sh | head -5`

    application,count
    Drupal,35
    Joomla,34
    WordPress,30
    SetSeed,22
