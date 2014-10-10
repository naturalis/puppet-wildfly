#
#
class wildfly::deploy  (
  $filename,
  $deploy_type = 'package',
)
{
  if ($deploy_type == 'package') {
    file { "/tmp/${filename}":
      source => [ "puppet:///modules/wildfly/${filename}" ]
    } ~>

    exec { "deploy ${filename}":
      command     => "/bin/sh  /opt/wildfly/bin/jboss-cli.sh --connect --command='deploy /tmp/${filename} --force'",
      refreshonly => true,
    }
  }

}
