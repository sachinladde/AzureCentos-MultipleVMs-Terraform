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
  
  
  
  
  
  
  
  [terraform website]: https://www.terraform.io/downloads.html
