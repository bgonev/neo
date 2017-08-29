class php-fpm {

exec { 'download-epel-repo':
  command => 'wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
}

exec { 'download-remi-repo':
  command => 'wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm'
}

exec { 'install-repos':
  command => 'rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm'
}

exec { 'enable-remis-repo':
  command => 'yum-config-manager --enable remi-php70'
}

exec { 'yum-update':
  command => '/usr/bin/yum update'
}

package { 'php-fpm':
  require => Exec['yum-update'],
  ensure => installed,
}

package { 'php-mysql':
  require => Exec['yum-update'],
  ensure => installed,
}

service { 'php-fpm':
  ensure => running,
}
