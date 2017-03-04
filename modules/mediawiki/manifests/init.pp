# Class: mediawiki
# ===========================
#
# Full description of class mediawiki here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mediawiki':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class mediawiki {

  $wikisitename      = hiera('mediawiki::wikisitename')
  $wikiserver        = hiera('mediawiki::wikiserver')
  $wikidbserver      = hiera('mediawiki::wikidbserver')
  $wikidbname        = hiera('mediawiki::wikidbname')
  $wikidbuser        = hiera('mediawiki::wikidbuser')
  $wikidbpassword    = hiera('mediawiki::wikidbpassword')
  $wikiupgradekey    = hiera('mediawiki::wikiupgradekey')

  $phpmysql = $osfamily ? {
    default  => 'php-mysql',
  }

  if $osfamily != 'windows' { ## Exclude Windows from receiving the php-mysql package
    package { $phpmysql:
      ensure => 'present',
    }
  }


  $phpxml = $osfamily ? {
    default => 'php-xml',
   }

  if $osfamily != 'windows' { ## Exclude Windows from receiving the php-xml package
    package { $phpxml:
      ensure => 'present',
    }
  }


  if $osfamily == 'debian' {
    package { 'php-mbstring':
      ensure => 'present',
   }
  }


  if $osfamily != 'windows' { ## Exclude Windows from receiving the ::apache class
    class { '::apache':
      docroot    => '/var/www/html',
      mpm_module => 'prefork',
      subscribe  => Package[$phpmysql],
    }
  }

  if $osfamily != 'windows' { ## Exclude Windows from receiving the ::apache::mod::php class
    class { '::apache::mod::php':}
  }

  if $osfamily != 'windows' { ## Exclude Windows from receiving the vcsrepo
    vcsrepo { '/var/www/html':
      ensure   => 'present',
      provider => 'git',
      source   => "https://github.com/wikimedia/mediawiki.git",
      revision => 'REL1_23',
    }
  }

  if $osfamily != 'windows' { ## Exclude Windows from removing /var/www/html/index.html
    file { '/var/www/html/index.html':
      ensure => 'absent',
    }
  }


  if $osfamily != 'windows' { ## Exclude Windows from  Resource Ordering vcsrepo
    File['/var/www/html/index.html'] -> Vcsrepo['/var/www/html']
  }


  if $osfamily != 'windows' { ## Exclude Windows from receiving the ::mysql::server class
    class { '::mysql::server':
      root_password => 'sqlpassword',
    }
  }


  if $osfamily != 'windows' { ## Exclude Windows from receiving the firewall class
    class {'::firewall': }
  }

  if $osfamily != 'windows' { ## Exclude Windows from receiving the firewall rules
    firewall { '000 allow http access':
      port   => '80',
      proto  => 'tcp',
      action => 'accept',
    }
  }

  file { 'LocalSettings.php':
    path => '/var/www/html/LocalSettings.php',
    ensure => 'file',
    content => template('mediawiki/LocalSettings.erb'),
  }
}

### Comment the file definition above to stop the creation of the LocalSettings.php file
### The database for MediaWiki needs to be created before the LocalSettings.php file can be pushed.
### This is only needed when setting up a new MediaWiki Database, then uncomment when the MediaWiki Setup is complete
### Then Add hiera variables as needed for the new server
#  file { 'LocalSettings.php':
#    path => '/var/www/html/LocalSettings.php',
#    ensure => 'file',
#    content => template('mediawiki/LocalSettings.erb'),
#  }

#}
