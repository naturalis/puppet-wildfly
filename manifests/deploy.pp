#
#
class wildfly::deploy  (
  $filename,
  $filelocation = 'puppet:///modules/wildfly',
  $deploy_type  = 'package',
)
{
  if ($deploy_type == 'package') {
    file { "/tmp/${filename}":
      source => [ "${filelocation}/${filename}" ]
    } ~>

    exec { "deploy ${filename}":
      command     => "/bin/sh  /opt/wildfly/bin/jboss-cli.sh --connect --command='deploy /tmp/${filename} --force'",
      refreshonly => true,
    }
  }

}
