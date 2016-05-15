class { 'java': }
class { 'tomcat': }
class { 'tomcat::instances': }
class { 'mysql::server': }
class { 'mysql::dbs': }
class { 'sonarqube': }
include sudo
include sudo::configs
