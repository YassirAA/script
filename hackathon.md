# HACKATHON

## PREPARACIO
  ### AWSCLI
  El primer de tot es instalar i configurar el aws
  ``` bash
  sudo apt update && sudo apt upgrade -y
  sudo apt install curl unzip -y
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  aws --version
  ```

Una vegada instalat anem a configurar les credencials
Primer fem 
 ``` bash
  aws configure
  ```
Despres posem el que ens demana que serien les claus i la regio en la que estem 

![image](https://github.com/user-attachments/assets/abbaeda0-5ba7-44d9-9557-060a49dced3f)

![image](https://github.com/user-attachments/assets/df8e3f7b-78f7-4290-83fe-113b9c05639c)

Despress tornem a copiar les claus al fitxer .aws/credentials
``` bash
  echo " credencials " > .aws/credentials
  ```
