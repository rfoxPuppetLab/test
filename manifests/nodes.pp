

node 'rfox-pupcentos' {
  hiera_include('classes')
}

node 'rfox-pupubuntu' {
  hiera_include('classes')
}

node 'rfox-win7pagent.lab.local' {
  hiera_include('classes')
}

node 'rfox-nectarrig.lab.local' {
  class { 'nectar_6022x64_test': }
}

class linux {

  $admintools = ['git', 'nano', 'screen']

  package { $admintools:
    ensure => 'installed',
  }

  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    default  => 'ntp',
  }

  file { '/info.txt':
    ensure  => 'present',
    content => inline_template("Created by Puppet at <%=Time.now%>\n"),
  }

  package { 'ntp':
    ensure => 'installed',
  }

  service { $ntpservice:
    ensure => 'running',
    enable => true,
  }
}
