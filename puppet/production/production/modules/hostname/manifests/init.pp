class systemd::hostname (
  $hostname = undef,
) {
    unless empty($hostname) {
    exec { "hostnamectl set-hostname ${hostname}":
      command => "/usr/bin/hostnamectl --no-ask-password set-hostname '${hostname}'",
      unless  => "/usr/bin/hostnamectl status | grep -q 'Static hostname: ${hostname}'";
    }
  }
}
