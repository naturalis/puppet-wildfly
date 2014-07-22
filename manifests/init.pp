#== Class: wildfly

class wildfly(
  $bind_address = $::ipaddress,
  $bind_address_management = '127.0.0.1',
  $version =  params_lookup( 'version' ),
) inherits wildfly::params {


  class{'wildfly::install': } ->
  class{'wildfly::config': } ~>
  class{'wildfly::service': } ->
  Class["wildfly"]

}
