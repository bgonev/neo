class ntp {

  package { 'ntp':
    ensure => installed,
  }
  file { 'ntp.conf':
    path    => '/etc/ntp.conf',
    ensure  => file,
    require => Package['ntp'],
    source  => "/home/puppet/files/allservers/ntp/ntp.conf"
  }
  service { 'ntp':
    name      => ntpd,
    ensure    => running,
    enable    => true,
    subscribe => File['ntp.conf'],
  }
}
