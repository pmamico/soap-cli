

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Mac OS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)

# soap-cli
Send SOAP messages from command line like  
```
$ soap https://eio-soap-sample.herokuapp.com:443/ws sample_request.xml
```


## demo
![demo](soap_cli.gif)


## How to install

run: 
```
curl -sL 'https://raw.githubusercontent.com/pmamico/soap-cli/main/install.sh' | bash
```
for windows, use `Git Bash` or bash enabled powershell as system administrator.

    
## Manual
```
Send SOAP messages from command line.
Usage: soap [-u|--update <arg>] [-v|--value <arg>] [-h|--help] <endpoint> <request>
	<endpoint>: SOAP endpoint url
	<request>: SOAP request file
	-u, --update: update the the value by given XPath; valid only with value option (no default)
	-v, --value: update the the value by given XPath; valid only with update option (no default)
	-h, --help: Prints help
```

## Requirements

* `curl` 
* `xmllint` 
* `xmlstarlet`

## Credits

Script skeleton generated with https://argbash.io/
