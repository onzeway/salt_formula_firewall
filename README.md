# SALT Firewall Formula

Install the iptables package and generates defined rules

See the full [Salt Formulas installation and usage instructions](http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html).

## Usage

Refer to pillar.example file to have a complete list pillar items supported by this formula.

## Installation

Put your formula under your master subdirectory for formulas and enjoy...

## Available states

`firewall`

Installs the iptables package.

`firewall.rules`

Configure rules on server firewall and apply them.

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Make your changes, and add tests for them
4. Test your changes (phpunit)
5. Commit your changes (git commit -am 'Add some feature')
6. Push to the branch (git push origin my-new-feature)
7. Create new Pull Request

## Versioning

This library uses semantic version numbers to better describe what code one might have installed, and indicate backwards incompatible changes.
Releases will be numbered in the following format:

major.minor.patch

And constructed with the following guidelines:
* Breaking backward compatibility bumps the major (and resets the minor and patch)
* New additions without breaking backward compatibility bumps the minor (and resets the patch)
* Bug fixes and misc changes bumps the patch

For more information on SemVer, visit ["SemVer"](http://semver.org/).

## License
Copyright (c) 2015 Onzeway

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see ["GNU Licenses"](http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).
![GNU GPLv3](https://www.gnu.org/graphics/gplv3-88x31.png "GNU GPLv3") 