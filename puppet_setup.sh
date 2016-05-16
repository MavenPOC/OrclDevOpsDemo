{
#!/bin/bash
if [ "$1" == "jenkins" ] || [ "$1" == "tomcat" ] || [ "$1" == "jenkins-light" ] || [ "$1" == "monitoring" ]
then

os=$(python -c "import platform;print(platform.linux_distribution()[0])")
	if [ "$os" == "Ubuntu" ]
	then
		sudo wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb 
		sudo dpkg -i puppetlabs-release-trusty.deb 
		sudo  update -y  
		sudo apt-get install puppet -y
		sudo apt-get install git -y
	else
		sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
		sudo yum -y install puppet
        sudo yum install git -y	
	fi
		
	# cloning git repo
	rm -rf OrclDevOpsDemo
	git clone https://github.com/MavenPOC/OrclDevOpsDemo.git

    mkdir -p /etc/puppet/manifests

	cp -r OrclDevOpsDemo/AwsSetup/modules/* /etc/puppet/modules/
	cp -r OrclDevOpsDemo/AwsSetup/manifests/* /etc/puppet/manifests/
	cp -r OrclDevOpsDemo/AwsSetup/hieradata /etc/puppet/
	cp OrclDevOpsDemo/AwsSetup/hiera.yaml /etc/puppet/

	if [ "$1" == "jenkins" ]
	then
		cp /etc/puppet/manifests/jenkins-nexus-"${os}".pp /etc/puppet/manifests/site.pp
		puppet apply /etc/puppet/manifests/site.pp --debug
		echo " "
		echo " "
		echo "jenkins has been setup alongside with Nexus"
		echo "*******************************************"
		echo "jenkins url http://<server_ip>:8080"
		echo "*******************************************"
		echo "Nexus url http://<server_ip>:8081 and username/passwd admin/admin123"
		echo " "
		echo " "
	fi
	if [ "$1" == "tomcat" ]
    then
		cp /etc/puppet/manifests/tomcat-sonar.pp /etc/puppet/manifests/site.pp 
        puppet apply /etc/puppet/manifests/site.pp --debug
        echo " "
		echo " "
        echo "Tomcat has been setup alongside with sonar"
        echo "*******************************************"
		echo "Tomcat url http://<server_ip>:8080/Spring3HibernateApp/"
		echo "*******************************************"
		echo "Sonar url http://<server_ip>:9000 and username/passwd admin/admin"
		echo " "
		echo " "
	fi
    if [ "$1" == "jenkins-light" ]
    then
        cp /etc/puppet/manifests/jenkins-light-"${os}".pp /etc/puppet/manifests/site.pp
        puppet apply /etc/puppet/manifests/site.pp --debug
        echo " "
        echo " "
		echo "Jenkins-light has been set up"
		echo " "
		echo " " 
    fi
    if [ "$1" == "monitoring" ]
    then
        cp /etc/puppet/manifests/monitoring.pp /etc/puppet/manifests/site.pp
        puppet apply /etc/puppet/manifests/site.pp --debug
        echo " "
        echo " "
		echo "zabbix has been setup alongside with kibana"
		echo "*******************************************"
		echo "zabbix url http://<server_ip> username/passwd admin/zabbix"
		echo "*******************************************"
		echo "kibana url http://<server_ip>:5601"
		echo " "
		echo " "
    fi	
else
	echo "please pass correct argument \"jenkins/jenkins-light/tomcat/monitoring\""   
fi
}
