class mysql-client {

exec { 'mysql-repo':
  command => 'wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
}

exec { 'install-mysql-repo':
  command => 'rpm -ivh mysql-community-release-el7-5.noarch.rpm'
}


exec { 'yum-update':
  command => '/usr/bin/yum update'
}


package { 'mysql-client':
  require => Exec['yum-update'],
  ensure => installed,
}
}
