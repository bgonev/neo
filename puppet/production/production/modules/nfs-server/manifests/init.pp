class nfs-server {

exec { 'yum-update':
  command => '/usr/bin/yum update'
}


package { "portmap":
	irequire => Exec['yum-update'],
        ensure => installed,
    }

package { "nfs-utils":
        require => Exec['yum-update'],
	ensure => installed,
    }

service { "portmap":
        ensure => running,
        enable => true,
        require => Package["portmap"],
    }

    service { "nfslock":
        ensure => running,
        enable => true,
        require => [
            Package["nfs-utils"],
            Service["portmap"],
        ],
    }

    service { "nfs":
        ensure => running,
        enable => true,
        require => Service["nfslock"],
    }

file { '/webshare':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0750',
  }

file { 'certs':
    path    => '/webshare/certs',
    ensure  => 'directory',
    owner => 'nginx',
    group => 'nginx',
  }

file { 'logs':
    path    => '/webshare/logs',
    ensure  => 'directory',
    owner => 'nginx',
    group => 'nginx',
  }

file { 'www.domain.com':
    path    => '/webshare/www.domain.com',
    ensure  => 'directory',
    owner => 'nginx',
    group => 'nginx',
  }


file { "exports":
        notify => Service['nfs'],
	path => "/etc/exports",
        ensure => present,
        backup => main,
        mode => 644,
        owner => root,
        group => root,
        source => "/home/puppet/files/nfs/exports"
}

}
