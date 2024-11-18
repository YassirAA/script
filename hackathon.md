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

Hem actualitzat l'script posant la creacio de la nostre maquina de windows i posant el seu grup  de seguretat i un nom 
``` bash
#! /bin/sh

# Definir variables
INSTANCE_TYPE="t2.micro"
AMI_ID="ami-05f283f34603d6aed"  # ID de la imatge Windows
KEY_NAME="vockey"
SECURITY_GROUP="sg-0f848561bd738058b"  # ID del grup de seguretat

# Llançar una nova instància
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WindowsServer}]'




DOMAINNAME=$1

#Verifiquem que el client no ha posat mes de 10 usuaris

if [ $# -gt 11 ];then
        echo "El nombre d'usuaris ha de ser menys de 10"
        exit 1
fi

#Script creacio maquina active directory amb el DOMAINNAME
#aws ec2 run-instances --image-id "ami-064519b8c76274859" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0f848561bd738058b"]}>

#aws ec2 run-instances --image-id "ami-064519b8c76274859" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0f848561bd738058b"]}>

shift

#Ens guardem les variables de usuari i contrasenya 

while [ $# -gt 0 ]
do
        USER=$(echo $1 | cut -d "," -f1)
        PSWD=$(echo $1 | cut -d "," -f2)

#Crearem la maquina aqui en un futur

        echo $USER $PSWD

        shift
done

```

Hem avançat en la creaccio del grup de seguretat i aconseguir crearlo adjuntanment amb la maquina virtual i posar el grup de seguretat a la maquina virtual
De moment tenim 3 reglas de ports oberts, el port de ssh(22), el port 80 de HTTP i el RDP(3389) tambe he separat en un script la creacio del windows server, el que fai es demanar el nom del grup primer i despres el nom de la maquina
![image](https://github.com/user-attachments/assets/81937121-7a78-490e-922e-a5936b51d157)

``` bash
#! /bin/sh

#Crear security group 
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name "$1" --description "Seguridad para hackathon" --query 'GroupId' --output text)


# Añadir reglas de acceso al grupo de seguridad
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0   # SSH
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0   # HTTP
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 3389 --cidr 0.0.0.0/0  # RDP para servidor Windows


# Definir variables
INSTANCE_TYPE="t2.micro"
AMI_ID="ami-05f283f34603d6aed"  # ID de la imatge Windows
KEY_NAME="vockey"
SECURITY_GROUP="$SECURITY_GROUP_ID"  # ID del grup de seguretat

# Llançar una nova instància
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$2'}]'

```

Ara aplicarem el nostre script de maquinas linux la seva creacio primer estem declaren les variables amb la informacio de la maquina virtual
``` bash
# Informacions dels Linux per la creacio de la maquina virtal
REGION="us-east-1"
AMI_ID="ami-064519b8c76274859"
INSTANCE_TYPE="t2.micro"
KEY_NAME="vockey"
SECURITY_GROUP_ID="sg-09897034353e50cc6"
```

Ara hem descrobert que per crear la maquina virtual es pot fer directament, pero per crear els usuaris que ens demana l'usuari ens hem de connectar per ssh.

Primer farem un bucle que creara les instancies que ens demana l'usuari i a dintre crearem els usuaris necesaris despres d'agafar la ip de la instancia creada per el ssh, i aixis fins que el bucle de les maquinas acabi, i ja tindriem els clients debian creats.

``` bash
bin/sh

NUMINST=$1

#Verifiquem que el client no ha posat mes de 10 usuaris

if [ $NUMINST -gt 10 ];then
        echo "El nombre d'instancies ha de ser menys de 10"
        exit 1
fi

shift

while [ $NUMINST -gt 0 ]    
do
#Informacions dels Linux per la creacio de la maquina virtal
REGION="us-east-1"
AMI_ID="ami-064519b8c76274859"
INSTANCE_TYPE="t2.micro"
KEY_NAME="vockey"
SECURITY_GROUP_ID="sg-09897034353e50cc6"

# Ens guardem les variables de usuari i contrasenya



while [ $# -gt 1 ]
do
        USER=$(echo $1 | cut -d "," -f1)
        PSWD=$(echo $1 | cut -d "," -f2)



        echo $USER $PSWD

        shift
done

done


```
