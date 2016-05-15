class{ '::java': }->

class{ '::nexus':
    revision   => '01',
    version    => '2.11.4',
    nexus_context =>  "",
    nexus_root => "/opt"
}
class { 'jenkins':
  install_java => false,
  version => '1.651.1',
  lts    => true,
  executors => 3,
  plugin_hash => {
    'github' 			=> {}, 			
    'git'			=> {},		
    'junit'                       => {},
    'parameterized-trigger' 	=> {},
    'conditional-buildstep' 	=> {},
    'htmlpublisher'             => {},
    'promoted-builds' 		=> {},	
    'maven-plugin'      	=> {manage_config => true,
                                     config_filename => 'hudson.tasks.Maven.xml',
                                     config_content => template('jenkins/config/plugin/hudson.tasks.Maven.xml.erb')},        
    'sonar'    			=> { manage_config => true,
 				     config_filename => 'hudson.plugins.sonar.SonarGlobalConfiguration.xml',
				     config_content => template('jenkins/config/plugin/hudson.plugins.sonar.SonarGlobalConfiguration.xml.erb') },
    'xvfb'     			=> {manage_config => true,
                                     config_filename => 'org.jenkinsci.plugins.xvfb.Xvfb.xml',
                                     config_content => template('jenkins/config/plugin/org.jenkinsci.plugins.xvfb.Xvfb.xml.erb')}
   },
  job_hash => {
    'OrclCiCdPOC Deploy'		=> { config => template("jenkins/config/jobs/OrclCiCdPOC_Deployment.xml.erb") },
    'OrclCiCdPOC Junit'        		=> { config => template("jenkins/config/jobs/OrclCiCdPOC_Junit.xml.erb") },
    'OrclCiCdPOC Release'        	=> { config => template("jenkins/config/jobs/OrclCiCdPOC_Release.xml.erb") },
    'OrclCiCdPOC Selenium'        	=> { config => template("jenkins/config/jobs/OrclCiCdPOC_Selenium.xml.erb") },
    'OrclCiCdPOC Sonar'        		=> { config => template("jenkins/config/jobs/OrclCiCdPOC_Sonar.xml.erb") },
  }
 }->
class { "ssh::jenkins": }

class { 'display':
  display => 99, 
  width   => 1024,
  height  => 768,
}
