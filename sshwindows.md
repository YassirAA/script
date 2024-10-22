# Documentacio Windwos Conectar
First we need to create the virtual machine in aws, is going to be a windwos command mode.


This is the configuration code
```bash
aws ec2 run-instances --image-id "ami-05f283f34603d6aed" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-043cafb8fe8705658"]}' --credit-specification '{"CpuCredits":"standard"}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1"
```
## Connect to RDP
Now we need to connect to our windwos with rdp

First we are going to our instance and click on connect, then we get our .pem key and decipher on the show password RDP option (j!WQ=AqD5s1N&CO4.!*(aVf?vXNfCmdH)
![Captura de pantalla 2024-10-21 205206](https://github.com/user-attachments/assets/1e2014bf-450a-4c8e-b5b6-34b85a565371)

We can download our rdp file and execute it, it would ask us the password and we put the one that gave us the .pem file
![image](https://github.com/user-attachments/assets/812d26e4-f1a0-433b-9b47-57a63158a5fe)

And that's it we connected
![image](https://github.com/user-attachments/assets/3e5bdfc0-8bf7-47fb-80dc-b0ee08280578)

## Configure SSH
Now we need to firstly install ssh in our windwows
Instalem el ssh-server
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
Activem el servei
```powershell
Get-Service sshd
Get-Service ssh-agent
```
