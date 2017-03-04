# Class: nectar_6022x64_test
# ===========================
#
# Full description of class nectar_6022x64_test here.
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
#    class { 'nectar_6022x64_test':
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
class nectar_6022x64_test {

## Create necessary Hiera Variables for the rigInstaller_Stack_1.erb Template that will be used to create the rigInstaller_Stack_1.props file
  $propscustomer     = hiera('nectar_6022x64_test::propscustomer')
  $propssite         = hiera('nectar_6022x64_test::propssite')
  $propsdescription  = hiera('nectar_6022x64_test::propsdescription')
  $propsservername   = hiera('nectar_6022x64_test::propsservername')

## Download the Nectar CAROUSEL-UCF-64bit-Installer-6.0.2.2
  file { 'c:/temp/':
    ensure => 'directory',
 }

  download_file { "Carousel Rig Server":
    url                   => 'http://www.foxcom.us/puppet/CAROUSEL-UCF-64bit-Installer-6.0.1.exe',
    destination_directory => 'c:\temp',
  }

## Create CAROUSEL-UCF-64bit-Installer directory tree for extraction
  file { [ 'C:/Program Files (x86)/Common Files/UCF/', 'C:/Program Files (x86)/Common Files/UCF/carousel/', 'C:/Program Files (x86)/Common Files/UCF/carousel/6.0.1/', 'C:/Program Files (x86)/Common Files/UCF/carousel/6.0.1/64bit/' ]:
    ensure => 'directory',
  }

## Extract the Nectar CAROUSEL-UCF-64bit-Installer-6.0.2.2.exe executable 
  include '::archive'
  include '::chocolatey'

  exec { 'extract CAROUSEL-UCF-64bit-Installer-6.0.1.exe':
    path    => $::path,
    command => 'cmd.exe /c ""C:/Program Files/7-Zip/7z.exe" x "C:/temp/CAROUSEL-UCF-64bit-Installer-6.0.1.exe" -aos -o"C:/Program Files (x86)/Common Files/UCF/carousel/6.0.1/64bit/"',
  }

## Create the rigInstaller_Stack_1.props file from rigInstaller_Stack_1.erb template
  file { 'rigInstaller_Stack_1.props':
    path    => 'C:/Program Files (x86)/Common Files/UCF/carousel/6.0.1/64bit/rigInstaller_Stack_1.props',
    ensure  => 'file',
    content => template('nectar_6022x64_test/rigInstaller_Stack_1.erb'),
    require => Exec['extract CAROUSEL-UCF-64bit-Installer-6.0.1.exe'], 
  }

### Perform installation
  exec { 'Carousel RIG Server':
    path    => $::path,
    command => 'cmd.exe /c "C:/Program Files (x86)/Common Files/UCF/carousel/6.0.1/64bit/installer.bat" --silent --install rigInstaller_Stack_1.props',
  }
}
##  archive { 'c:/temp/CAROUSEL-UCF-64bit-Installer-6.0.1.exe':
##    source       => 'c:/temp/CAROUSEL-UCF-64bit-Installer-6.0.1.exe',
##    ensure       => present,
##    extract      => true,
##    extract_path => 'C:/Program Files (x86)/Common Files/UCF/carousel/6.0.1/64bit',
##    source => 'http://www.foxcom.us/puppet/CAROUSEL-UCF-64bit-Installer-6.0.1.exe',
##    username => 'Carousel',
##    password => 'Sm@rtP01nt#',
##  }

## Process the creation of the rigInstaller_Stack_1.props file before kicking off the installer.bat 
#  File['C:\Program Files (x86)\Common Files\UCF\carousel\6.0.2.2\64bit\'] -> Vcsrepo['C:\']
#  }

### Works but haven't found a way to wait until completion
## Launch the CAROUSEL-UCF-64bit-Installer-6.0.1.exe to extract 
##  exec { 'Launch CAROUSEL-UCF-64bit-Installer-6.0.1.exe to extract':
##    path    => $::path,
##    command => "cmd.exe /c c:/temp/CAROUSEL-UCF-64bit-Installer-6.0.1.exe --install --silent",
##  }

#  package { "Carousel RIG Server Extract Only":
#   ensure          => 'installed',
#   source          => 'c:/temp/CAROUSEL-UCF-64bit-Installer-6.0.1.exe',
#   install_options => [ '--install --silent --rigInstaller.props'],
#  }
