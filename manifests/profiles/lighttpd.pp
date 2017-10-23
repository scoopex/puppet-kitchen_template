# == Class: kitchen_template::profiles::lighttpd
#
class kitchen_template::profiles::lighttpd(
	$installed,
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

    file { "/var/www/html/test.html":
      owner   => "www-data",
      group   => "www-data",
      mode    => '0644',
      content => "<h1>${message}</h1>",
    }
  }else{
		 package{ 'lighttpd':
			 ensure => absent,
		 }
     file { "/var/www/html/test.html":
			 ensure => absent,
     }
  }
}
