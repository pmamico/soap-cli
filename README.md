

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Mac OS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)  
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)

# soap-cli
Send SOAP messages from command line like \\
```
$ soap http://soap_url/soap_endpoint request.xml
```
output
```
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns2:ExampleResponse xmlns:ns2="http://soap_url" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <return>
       	Hello World!
      </return>
    </ns2:ExampleResponse>
  </soap:Body>
</soap:Envelope>
```


## How to install

run: 
```
curl -sL 'https://raw.githubusercontent.com/pmamico/soap-cli/main/install.sh' | bash
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
