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

    exec { "doublecheck deployment of ${filename}":
      command     => "/bin/sh  /opt/wildfly/bin/jboss-cli.sh --connect --command='deploy /tmp/${filename} --force'",
      unless      => "/bin/sh /opt/wildfly/bin/jboss-cli.sh --connect --command='deployment-info' | /bin/grep ${filename} | /bin/grep true | /bin/grep OK",
      require     => File["/tmp/${filename}"],
    }
  }

}
