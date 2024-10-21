# Documentacio Windwos Conectar
First we need to create the virtual machine in aws, is going to be a windwos command mode.


This is the configuration code
```bash
aws ec2 run-instances --image-id "ami-05f283f34603d6aed" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-043cafb8fe8705658"]}' --credit-specification '{"CpuCredits":"standard"}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1"
```
## Connect to RDP
Now we need to connect to our windwos with rdp

First we are going to our instance and click on connect, then we get our .pem key and decipher on the show password RDP option

