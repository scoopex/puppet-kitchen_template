# == Class: kitchen_template::profiles::lighthttpd
#
class kitchen_template::profiles::lighthttpd(
	$installed = true,
  $message = "WELCOME"
){
	if $installed {
		package{ 'lighttpd':
			ensure => present,
		}
		-> service { "lighttpd":
			ensure     => true,
			enable     => true
		}

    file { "/var/www/test.html":
      owner   => "www-run",
      group   => "www-run",
      mode    => '0644',
      content => "<h1>${message}</h1>",
    }
  }else{
		 package{ 'lighttpd':
			 ensure => absent,
		 }
     file { "/var/www/test.html":
			 ensure => absent,
     }
  }
}
