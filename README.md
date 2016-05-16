# OrclCiCdPOC

## AWS AMI CentOS-6.5-base-20150305 - ami-777f9b33

##Setup monitoring
create a aws ec2 instace or spin up vagrant
run following command under root user  with **172.31.0.30**(private ip) ip adrress
```
curl https://raw.githubusercontent.com/OpsTree/OrclCiCdPOC/master/puppet_setup.sh | bash -s -- monitoring
```
It will install zabbix and kibana 
After completing installation enable auto registration in zabbix 


##To Setup Tomcat 

create a aws ec2 instace or spin up vagrant with **172.31.0.10**(private ip) ip adrress if you are using AWS then use this elastic ip **52.9.101.203**

run following command under root user
```
curl https://raw.githubusercontent.com/OpsTree/OrclCiCdPOC/master/puppet_setup.sh | bash -s -- tomcat
```
It will also setup sonar alonside Tomcat


##To Setup Jenkins
create a aws ec2 instace or spin up vagrant 

run following command under root user
```
curl https://raw.githubusercontent.com/OpsTree/OrclCiCdPOC/master/puppet_setup.sh | bash -s -- jenkins
```
It willl also setup nexus alonside Jenkins 

##To Setup Light jenkins
create a aws ec2 instace or spin up vagrant

run following command under root user
```
curl https://raw.githubusercontent.com/OpsTree/OrclCiCdPOC/master/puppet_setup.sh | bash -s -- jenkins-light
```
It willl also setup nexus alonside Jenkins 
