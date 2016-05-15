define jenkins::plugins_install (
 $plugin_extention = undef,
){
 exec { "${plugin_extention}-plugin-installlation":
    command     => "/bin/bash -c \"/usr/bin/java -jar /usr/share/jenkins/jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin ${name}\"",
    logoutput   => 'true',
    cwd         => "/var/lib/jenkins",
    user        => "jenkins",
    unless      => "test -e /var/lib/jenkins/plugins/${name}*",
    provider    => shell,
    require     => Exec['jenkins-cli']
  }

}
