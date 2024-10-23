# Contrasenya RDP 
```
yPIvLux*D-KRxs-X4(Q$U0HUk)JGEtoe
```

# Documentacio Windwos Conectar
First we need to create the virtual machine in aws, is going to be a windwos command mode.


This is the configuration code
```bash
aws ec2 run-instances --image-id "ami-05f283f34603d6aed" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-043cafb8fe8705658"]}' --credit-specification '{"CpuCredits":"standard"}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1"
```
## Connect to RDP
Now we need to connect to our windwos with rdp

First we are going to our instance and click on connect, then we get our .pem key and decipher on the show password RDP option 
![Captura de pantalla 2024-10-21 205206](https://github.com/user-attachments/assets/1e2014bf-450a-4c8e-b5b6-34b85a565371)

We can download our rdp file and execute it, it would ask us the password and we put the one that gave us the .pem file
![image](https://github.com/user-attachments/assets/812d26e4-f1a0-433b-9b47-57a63158a5fe)

And that's it we connected
![image](https://github.com/user-attachments/assets/3e5bdfc0-8bf7-47fb-80dc-b0ee08280578)

## Configure SSH
Now we need to firstly install ssh in our windwows
Install ssh
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
Activate the service
```powershell
Get-Service sshd
Get-Service ssh-agent
```

We make it automatic
```powershell
Set-Service -Name sshd -StartupType Automatic
Set-Service -Name ssh-agent -StartupType Automatic
```
We run the service
```powershell
Start-Service sshd
Start-Service ssh-agent
```

We verify the service is working
```powershell
Get-Service ssh*
```

We create keys in out linux
```bash
ssh-keygen -t rsa -b 4096
```
Now we copy the public key
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDcviAEIlMpYZ2oB1Mv1KqwlACbyiZdG4JjcTrT0WdFvHzgMk7U8UV7tLMykFGXCilICtKjxJ3ERfS9kRSKay+JpxtdaFBrZCgymGxTW5/GJSRQYrvou6WazVzp48UBvn3EAtSuuMlGFGlwGwTtvdE80FSanmrzOwZrKg8TWG0kCQ5zaq+LkrTZ3aG7dIeVbK9edE3Dd2EOVF9CmOlAjhlZZ1m0VlB3JdghFG+sIDv+YxaIe32fcR4J1GUtdQiOiIv68Sr4tKED8W9Pk6Y8bylu+4fmNMPSHBrL+w4NyG1OUe0pc1jm0K0iBmlGzxyUv2AUzQ9zfKS6QKIL0YbyV/ruYlVrxLcUdFA2E12u+ZcvFiaeK1q9rthLCG31pZvRB78fcYncOg6IE8btqGdQti3QONeahf23dzCHBZekgms+xLgSeAs2LBOCFNeLc+nnRHvrO99/zEdDw85KsxitByAVER8/hjjhvC5nQTCndfB4iQqXY06B27ZBmb5UcTYZJh23Xk3OIdV7osb1Sdt0nBsG7PnMidea/G2nFq0+cc8oIRY/L1UII5unDQPGpK2m9mL9gHJ2ZxkEQ59oeG93IFAVpoekeUvTw+OpWhGZKZXqRk0dQ7Wbp19OWLFdNJemb1kqQLCJw0gFx8rSfdtYHPNPhg0CA8djiUFmgW9zoQlq2Q== a@a-VMware-Virtual-Platform
```
And create this structure in the windwos
```
\.ssh\authorized_keys
```
![image](https://github.com/user-attachments/assets/b9eda21a-51c0-4e7c-88b3-e0a8724cb89d)

Now we do the same to the configuration file Windows 
```
C:\programdata\ssh\administrator_authorized_keys
```
![image](https://github.com/user-attachments/assets/2bf20761-2523-4b4e-890c-ab4ed5b7b4a4)

Ara modificarem els permisos amb la seguent linea de comandas
``` powershell
icacls $env.USERPROFILE\.ssh /inheritance:r
icacls $env.USERPROFILE\.ssh /grant "$($env:USERNAME):(OI)(CI)F"
icacls $env.USERPROFILE\.ssh\authorized_keys /grant "$($env:USERNAME):F"
```

