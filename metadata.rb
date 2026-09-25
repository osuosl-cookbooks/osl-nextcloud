name              'osl-nextcloud'
maintainer        'Oregon State University'
maintainer_email  'chef@osuosl.org'
license           'All Rights Reserved'
description       'Installs/Configures osl-nextcloud'
issues_url        'https://github.com/osuosl-cookbooks/osl-nextcloud/issues'
source_url        'https://github.com/osuosl-cookbooks/osl-nextcloud'
chef_version      '>= 18.0'
version           '3.2.0'

depends          'ark'
depends          'osl-apache'
depends          'osl-php'
depends          'osl-repos'
depends          'osl-selinux'
depends          'osl-valkey', '>= 2.0.0'

# One line: supports keys on the platform name. valkey is in AppStream from 9.7.
supports 'almalinux', '>= 9.7'
