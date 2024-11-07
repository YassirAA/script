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

![image](https://github.com/user-attachments/assets/75406d23-0c65-4893-a1b2-bbdef4d0c269)

Per comprobar que funciona agafem el nostre script de creacio de maquines virtuals d'aws i farem una maquina virtual nova

![image](https://github.com/user-attachments/assets/928a7d7a-fd92-4468-b6a0-ac08e9e4182a)

Aquesta es la nova maquina virtual 

![image](https://github.com/user-attachments/assets/f02de5cc-bdeb-4ae8-b4d1-18b066652a92)

Com es pot veure te la mateixa ip que la informacio del nostre script

![image](https://github.com/user-attachments/assets/d0fcfaf2-b00f-42f2-a2c0-a9faab8ad94a)

## Creacio Script

  ``` bash
    #! /bin/sh
    
    DOMAINNAME=$1
    
    #Verifiquem que el client no ha posat mes de 10 usuaris
    
    if [ $# -gt 11 ];then
            echo "El nombre d'usuaris ha de ser menys de 10"
            exit 1
    fi
  ```

Execucio

![image](https://github.com/user-attachments/assets/a88d2922-9102-47c9-96e6-82964fb00a3b)

``` bash
#! /bin/sh

DOMAINNAME=$1

#Verifiquem que el client no ha posat mes de 10 usuaris

if [ $# -gt 11 ];then
        echo "El nombre d'usuaris ha de ser menys de 10"
        exit 1
fi

shift

#Ens guardem les variables de usuari i contrasenya 

while [ $# -gt 0 ]
do
        USER=$(echo $1 | cut -d "," -f1)
        PSWD=$(echo $1 | cut -d "," -f2)

        echo $USER,$PSWD

        shift
done
```
Ara verificarem si ens guarda aquestas dades

![image](https://github.com/user-attachments/assets/00d8c2b4-b85f-4fe1-aea3-b2914519c0db)
