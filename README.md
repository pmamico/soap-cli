![test](https://github.com/pmamico/soap-cli/actions/workflows/tests.yml/badge.svg) ![shellcheck](https://github.com/pmamico/soap-cli/actions/workflows/shellcheck.yml/badge.svg)

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)  
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Mac OS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)



# soap-cli
Send SOAP messages from command line like  
```
$ soap <url> <request.xml>
```

## Quick Demo
![demo](.doc/soap_cli.gif)


## How to install

run: 
```
curl -sL 'https://raw.githubusercontent.com/pmamico/soap-cli/main/install.sh' | bash
```
on Windows, use `Git Bash` or bash enabled `Powershell` **as system administrator**.

### Requirements

* `curl` 
* `xmllint` 
* `xmlstarlet`

Install all requirements

| OS            | via           | command                                                                          |
| ------------- |:-------------:| --------------------------------------------------------------------------:      |
| Ubuntu        | APT           | ```sudo apt-get install libxml2-utils```<br />```sudo snap install xmlstarlet``` |
| MacOs         | [HomeBrew](https://brew.sh/)      | ```brew install xmlstarlet```                                                    |
| Windows       | [Chocolatey](https://chocolatey.org/)    | ```choco install xmlstarlet```                                                   |
| Windows       | [Cygwin](https://cygwin.com/)<br/>[apt-cyg](https://github.com/transcode-open/apt-cyg) | ```apt-cyg install xmlstarlet```  |

    
## Manual
```
soap-cli v0.4
soap <endpoint> <request> [-u|--update <arg>] [-v|--value <arg>] [-d|--dry] [-h|--help] [--version] [curl options]
	<endpoint>: SOAP endpoint url
	<request>: SOAP request file
	-u, --update: update the the value by given XPath; valid only with value option (no default)
	-v, --value: update the the value by given XPath; valid only with update option (no default)
	-d, --dry: dry run, prints the curl command but do not execute
	-h, --help: Prints help
    All additional arguments and options passed to curl. (curl --help all)
```

### Updating a value by XPath (`--update`)

It's possible to update a single value by a given XPath before sending the request, like:
```
soap <endpoint> <request> --update "//nodeName" --value "newValue"
```
Note that this feature is designed to make only a fast change without editing your file, it's not possilbe to stack multiple `--update`.

### Passing curl options  
You can pass any standard curl option **after** `soap-cli` options.  
eg.
```
soap <endpoint> <request> -o output.xml --http1.0 --verbose
```

### Dry run (`--dry`)
Print the `curl` command which `soap-cli`  would run under the hood without execution.
```
soap <endpoint> <request> --dry
```

## Unit tests
You can run the tests yourself via
```
./unit_test.sh
```
and also get some idea how to use `soap-cli` by reviewing `test/soap_cli_test.sh`.

## Credits

* Script skeleton generated with https://argbash.io/
* Sample SOAP service used for demostrate: https://github.com/elasticio/soap-sample
* Testing framework: https://github.com/bats-core/bats-core
