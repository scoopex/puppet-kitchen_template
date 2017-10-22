# == Class: kitchen_template::init
#
class kitchen_template{

  ## ressource ordering
  class { '::kitchen_template2':} ->
  class { '::kitchen_template::profiles::lighttpd':}

  ## needed ressources
  include ::kitchen_template2
  include ::kitchen_template::profiles::lighttpd
}
