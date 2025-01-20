# OpenStreetMap Carto DE setup instructions

Setup of German style is no longer different than using upstream
OpenStreetMap carto style thus just refer to INSTALL.md for usage
instructions.

However if you want latin script osm2pgsql version 1.8.0 or higher is
required.

To create a database with latin script names use
```openstreetmap-carto-flex-l10n.lua``` instead of the one from upstream.

This will also require the installation of the
[osml10n](https://github.com/giggls/osml10n) software.

See [osml10n](https://github.com/giggls/osml10n) installation instructions for details.

If you want to change the target langugage from German to another language
using latin script change the 'L10NLANG' variable in
```openstreetmap-carto-flex-l10n.lua``` from 'de' to your desired language
e.g.  'en', 'fr' or 'es'.
