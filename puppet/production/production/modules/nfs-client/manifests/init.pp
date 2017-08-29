class nfs-client {

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

}
