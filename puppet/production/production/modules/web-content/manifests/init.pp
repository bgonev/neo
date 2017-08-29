class web-content {
  file { 'sites-available':
    path    => '/etc/nginx/sites-available',
    ensure  => 'directory',
    owner => 'root',
    group => 'root',
  }

file { 'sites-enabled':
    path    => '/etc/nginx/sites-available',
    ensure  => 'directory',
    owner => 'root',
    group => 'root',
  }

file { 'www.domain.com.conf':
    path    => '/etc/nginx/sites-available/www.domain.com.conf',
    ensure  => file,
    require => file['sites-vailable'],
    source  => "/home/puppet/files/web-config1/www.domain.com.conf"
  }
file { 'ssl.conf':
    path    => '/etc/nginx/sites-available/ssl.conf',
    ensure  => file,
    require => file['sites-vailable'],
    source  => "/home/puppet/files/web-config1/ssl.conf"
  }

exec {'available-http':
    require => file['www.domain.com.conf'],
    command => 'ln -s /etc/nginx/sites-enabled/www.domain.com.conf /etc/nginx/sites-available/www.domain.com.conf',
}

exec {'available-ssl':
    require => file['ssl.conf'],
    command => 'ln -s /etc/nginx/sites-enabled/ssl.conf /etc/nginx/sites-available/ssl.conf',
}

file { 'webshare':
    path    => '/webshare',
    ensure  => 'directory',
    owner => 'root',
    group => 'root',
  }

mount { "/webshare":
        device  => "nfsserver:/webshare",
        fstype  => "nfs",
	ensure  => "mounted",
	options => "",
        atboot  => "true",
    }

file { 'index.php':
    path    => '/webshare/www.domain.com/index.php',
    ensure  => 'file',
    owner => 'nginx',
    group => 'nginx',
    source => '/home/puppet/files/web-config1/index.php',
  }

exec {'restart':
command => '/sbin/service nginx restart'
}

}
