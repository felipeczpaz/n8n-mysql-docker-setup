# n8n-mysql-docker-setup

This repository contains a bash script (`setup_n8n_mysql_docker.sh`) that automates the setup of n8n with MySQL and Docker on Ubuntu systems. The script handles the installation of MySQL server, configuration of MySQL for n8n, installation of Docker, and running the n8n Docker container with basic authentication enabled.

## Setup Instructions

### Prerequisites

- Ubuntu Linux (tested on Ubuntu 20.04 LTS)
- Internet connection
- `sudo` privileges

### Server Configuration

### Server Configuration (AWS/Azure)

Before running the setup script on your AWS or Azure instance, ensure that the following server configuration is in place:

#### AWS EC2 Instance:

- **Security Group**: Update the inbound rules of your EC2 instance's security group to allow inbound traffic on ports `5678` (default for n8n) and `3306` (default for MySQL).

  Example inbound rule:
  - For n8n (port `5678`):
    - Type: Custom TCP Rule
    - Protocol: TCP
    - Port Range: 5678
    - Source: 0.0.0.0/0 (for wide open access, adjust as per your security requirements)
  - For MySQL (port `3306`):
    - Type: Custom TCP Rule
    - Protocol: TCP
    - Port Range: 3306
    - Source: 0.0.0.0/0 (adjust as necessary)

#### Azure Virtual Machine:

- **Network Security Group (NSG)**: Update the inbound rules of your Azure VM's NSG to allow inbound traffic on ports `5678` (default for n8n) and `3306` (default for MySQL).

  Example inbound rule:
  - For n8n (port `5678`):
     - Name: n8n_Port_5678
     - Priority: 100 (adjust as necessary)
     - Source: Any
     - Destination Port Range: 5678
     - Protocol: TCP
   - For MySQL (port `3306`):
     - Name: MySQL_Port_3306
     - Priority: 110 (adjust as necessary)
     - Source: Any
     - Destination Port Range: 3306
     - Protocol: TCP

 **UFW**: If `ufw` is enabled on your server, open ports `5678` and `3306`:

  ```bash
  sudo ufw allow 5678/tcp
  sudo ufw allow 3306/tcp
  ```

### Usage

1. Clone the repository to your Ubuntu server:

   ```bash
   git clone https://github.com/yourusername/n8n-mysql-docker-setup.git
   cd n8n-mysql-docker-setup
   ```
   
2. Edit the script (setup_n8n_mysql_docker.sh) and modify the constants for usernames and passwords (N8N_USERNAME, N8N_PASSWORD, MYSQL_ROOT_PASSWORD, MYSQL_N8N_USERNAME, MYSQL_N8N_PASSWORD) with your desired credentials.

3. Make the script executable:

  ```bash
  chmod +x setup_n8n_mysql_docker.sh
  ```

4. Execute the script with sudo:

  ```bash
  sudo ./setup_n8n_mysql_docker.sh
  ```

5. Follow the prompts and verify the setup completes successfully.

### Notes

- Ensure to review and customize the script according to your environment and security policies before running it in production.
- This script assumes default configurations and may need adjustments based on your specific requirements.

### License

This project is licensed under the MIT License - see the LICENSE file for details.

