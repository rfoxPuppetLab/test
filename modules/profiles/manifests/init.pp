# Class: profiles
# ===========================
#
# Full description of class profiles here.
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
#    class { 'profiles':
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
class profiles {

}

class profiles::windows::mysql_workbench {

  file { 'c:/temp/':
    ensure => 'directory',
  }

  download_file { "Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.30501":
    url                   => 'https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe',
    destination_directory => 'c:\temp',
  }

  package { "Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.30501":
    ensure          => 'installed',
    source          => 'c:\temp\vcredist_x64.exe',
    install_options => [ '/quiet'],
  }

  download_file { "Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026":
    url                   => 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe',
    destination_directory => 'c:\temp',
  }

  package { "Microsoft Visual C++ 2015 Redistributable (x64) - 14.0.23026":
    ensure          => 'installed',
    source          => 'c:\temp\vc_redist.x64.exe',
    install_options => [ '/quiet'],
  }


  download_file { "Microsoft .NET Framework 4.5.2":
    url                   => 'https://download.microsoft.com/download/5/6/2/562A10F9-C9F4-4313-A044-9C94E0A8FAC8/dotNetFx40_Client_x86_x64.exe',
    destination_directory => 'c:\temp',
  }

  package { "Microsoft .NET Framework 4.5.2":
    ensure          => 'installed',
    source          => 'c:\temp\dotNetFx40_Client_x86_x64.exe',
    install_options => [ '/q'],
  }

  download_file { "MySQL Workbench 6.3 CE":
    url                   => 'https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-6.3.9-winx64.msi',
    destination_directory => 'c:\temp',
  }

  package { "MySQL Workbench 6.3 CE":
    ensure          => 'installed',
    source          => 'c:\temp\mysql-workbench-community-6.3.9-winx64.msi',
    install_options => [ '/q'],
  }
}

class profiles::windows::putty {

  file { 'c:/admin tools/':
    ensure => 'directory',
  }

  download_file { "Download putty":
    url                   => 'https://the.earth.li/~sgtatham/putty/latest/x86/putty.exe',
    destination_directory => 'c:\admin tools',
  }

  download_file { "Download puttygen":
    url                   => 'https://the.earth.li/~sgtatham/putty/latest/x86/puttygen.exe',
    destination_directory => 'c:\admin tools',
  }
}
