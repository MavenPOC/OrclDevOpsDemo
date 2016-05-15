 {
#!/bin/bash
if [ "$1" == "jenkins" ] 
then
os=$(python -c "import platform;print(platform.linux_distribution()[0])")
	if [ "$os" == "Ubuntu" ]
	then
		sudo wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb 
		sudo dpkg -i puppetlabs-release-trusty.deb 
		sudo update -y  
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
     }
