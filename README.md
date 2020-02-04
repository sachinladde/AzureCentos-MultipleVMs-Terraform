# Azure Linux VMs
This project can be used to create multiple Linux VMs with SSH key and zure feature like boot diagnostics using Terraform script. One can also leverage Jenkins Pipeline as code feature to automate VM's deployment in Azure on each code commit in the git repository.


## Contents

* [Getting Started](#getting-started)
* [Demo](#demo)
* [Components](#components)
* [Features](docs/readmes/README.md#features)
* [What To Do Next?](#what-to-do-next)
* [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites
You will need one Linux VM for installing the tools like Git, Terraform, Ansible. Below are the installation steps for required tools.

### 1. Install Terraform

- Install Wget Package 

  GNU Wget is a free and open source software package for retrieving files using HTTP, HTTPS, and FTP, the most widely-used Internet protocols. The GNU/wget might not be installed on your system and here is how to install it using yum command.
 
  ```shell
   sudo yum install wget unzip
   ```
- Download terraform package using wget.

  Here i am downloading Terraform version 11.13. But if you want to download latest version of terraform you can download it from [terraform website]
  
   ```shell
  wget  https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
  ```
- Unzip the downloaded package by using unzip command, it will extract one binary file called ‘terraform’  
   ```shell
  unzip terraform_0.11.13_linux_amd64.zip 
   ```
- Copy unzipped terraform file to /usr/local/bin
   ```shell
  sudo cp terraform /usr/local/bin
     ```
- Give executable permission    
   ```shell
  sudo chmod +x /usr/local/bin
     ```
- Now check terraform
	Because we have copied the binary file to /usr/local/bin, the terraform command is available. You can check its absolute path by using   command 
    ```shell
  which terraform
     ```    
- The below command will show the version of terraform.
   ```shell
  terraform --version   
    ```
### 2. Installing Jenkins
- Jenkins is a Java application, so the first step is to install Java. Run the following command to install the OpenJDK 8 package:
   ```shell
  sudo yum install java-1.8.0-openjdk-devel   
    ```
- The next step is to enable the Jenkins repository. To do that, import the GPG key using the following curl command
   ```shell
  curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo   
    ```
- And add the repository to your system with below command
   ```shell
  sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key   
    ```
- Once the repository is enabled, install the latest stable version of Jenkins by typing:
   ```shell
  sudo yum install jenkins   
    ```
- After the installation process is completed, start the Jenkins service with:
  ```shell
  sudo systemctl start jenkins   
    ```
- To check whether it started successfully run:
  ```shell
  systemctl status jenkins   
    ```
- Finally enable the Jenkins service to start on system boot.
  ```shell
  sudo systemctl enable jenkins   
    ```
- If you are installing Jenkins on a remote CentOS server that is protected by a firewall you need to open port 8080. Use the following commands to open the necessary port. Also make sure that you have opened the http port on Azure NSG inside VM's networking option
  ```shell
  sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
  sudo firewall-cmd --reload  
    ```
- If you want to access jenkins console from your local desktop, then you need to bind local 8080 port with the VM on which jenkins is installed. Also make sure that your VM and Desktop public keys are identical.
  ```shell
  ssh -L 127.0.0.1:8080:localhost:8080 Nancy@ansi.southindia.cloudapp.azure.com  
    ```
#### 2.1 Setting up Jenkins
 - To set up your new Jenkins installation, open your browser and type your domain or IP address followed by port 8080. If your VM is on    any cloud platform then use public IP of that vm to access Jenkins console. If you have bind your local desktop's port 8080 to the VM    then simply type localhost and Jenkins console will show up as below
    ```shell
  	http://your_ip_or_domain:8080
  	http://localhost:8080
  	http://<DNS Name of Azure Cloud VM>:8080
     ```
   
   ![unlock jenkins](unlock-jenkins.jpg)
 
 - Use the following command to print the password on your terminal:
     ```shell
  	sudo cat /var/lib/jenkins/secrets/initialAdminPassword
     ```
 - Copy the password from your terminal, paste it into the Administrator password field and click Continue
 
    
  [terraform website]: https://www.terraform.io/downloads.html
