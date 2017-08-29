class nginx {

exec { 'yum-update':
  command => '/usr/bin/yum update'
}

package { 'nginx':
  require => Exec['yum-update'],
  ensure => installed,
}

package { 'php-fpm':
  require => Exec['nginx'],
  ensure => installed,
}

service { 'nginx':
  ensure => running,
}

service { 'php-fpm':
  ensure => running,
}
}
