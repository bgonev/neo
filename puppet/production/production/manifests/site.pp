node default { }

node web1 {
include ntp
include nfs-client
include nginx
include php-fpm
include web-content
include mysql-client
}

node web2 {
include ntp
include nfs-client
include nginx
include php-fpm
include web-content
include mysql-client
}

node nfsserver {
include ntp
include nfs-server
}

node sql1 {
include ntp
include mysql-server
include mysql-master
}

node sql2 {
include ntp
include mysql-server
include mysql-slave
}
