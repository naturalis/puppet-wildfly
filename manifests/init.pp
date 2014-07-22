#== Class: wildfly

class wildfly(
  $bind_address = $::ipaddress,
  $bind_address_management = '127.0.0.1',
  $version =  params_lookup( 'version' ),
  $use_web_download = params_lookup( 'use_web_download' ),
  $download_server = params_lookup( 'download_server' ),
) inherits wildfly::params {


  class{'wildfly::install': } ->
  class{'wildfly::config': } ~>
  class{'wildfly::service': } ->
  Class['wildfly']

}
