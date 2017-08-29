class mysql-server {

exec { 'mysql-repo':
  command => 'wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
}

exec { 'install-mysql-repo':
  command => 'rpm -ivh mysql-community-release-el7-5.noarch.rpm'
}


exec { 'yum-update':
  command => '/usr/bin/yum update'
}


package { 'mysql-server':
  require => Exec['yum-update'],
  ensure => installed,
}

service { 'mysql':
  ensure => running,
}


file { 'secure-it.sh':
    path    => '/tmp/secure-it.sh',
    ensure  => file,
    require => Package['mysql-server'],
    source  => "/home/puppet/files/mysql-server/secure-it.sh"
  }


file {
    '/tmp/secure-it.sh':
      ensure => 'file',
      path => '/tmp/secure-it.sh',
      owner => 'root',
      group => 'root',
      mode  => '0755', 
      notify => Exec['run_script'],
  }
exec { 'run_script':
  command => '/tmp/secure-it.sh',
  refreshonly => true
  }
}
