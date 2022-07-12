

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Mac OS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)  

# soap-cli
Send SOAP messages from command line like \\
```
soap http://example.com/soap_endpoint request.xml
```

## How to install

run: 
```
curl -sL https://raw.githubusercontent.com/pmamico/jsoap-cli/main/install.sh | bash
```
for windows, use `Git Bash` or bash enabled powershell as system administrator.

    
## Manual
```
Send SOAP messages from command line.
Usage: ./soap [-h|--help] <endpoint> <request>
	<endpoint>: SOAP endpoint
	<request>: SOAP request file
	-h, --help: Prints help
```

## Requirements

* `curl` 
* `xmllint` 

## Credits

Script skeleton generated with https://argbash.io/
