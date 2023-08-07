![test](https://github.com/pmamico/soap-cli/actions/workflows/tests.yml/badge.svg) ![shellcheck](https://github.com/pmamico/soap-cli/actions/workflows/shellcheck.yml/badge.svg)

# soap-cli
Send SOAP messages from command line like  
```
$ soap <url> <request.xml>
```

![demo](.doc/soap-cli.gif)


## How to install

via homebrew:
```
brew install pmamico/soap/soap-cli
```

or
```
curl -sL 'https://raw.githubusercontent.com/pmamico/soap-cli/main/install.sh' | bash
```
    
## Manual
```
soap-cli v1.3
Send SOAP messages from command line.
Usage:
soap <endpoint> <request> [-i|--interactive] [-U|--update <arg>] [-V|--value <arg>] [-d|--dry] [-h|--help] [-p|--pretty] [--version] [curl options]
	<endpoint>: SOAP endpoint url
	<request>: SOAP request file
	-i, --interactive: use your XML as template, update values interactively before send
	-U, --update: update the the value by given XPath; valid only with --value option
	-V, --value: update the the value by given XPath; valid only with --update option
	-d, --dry: dry run, prints the curl command but do not execute
	-p, --pretty:  syntax highlighting
	-h, --help: Prints help
	--version: Prints version number
	All additional arguments and options passed to curl. (see 'curl --help all')
	(except -U as proxy user, use --proxy-user instead)
```

### Interactive mode (`--interactive`)
Change the values in the XML in an interactive way.
```
soap <endpoint> <request> --interactive
```
This mode waits for user input for all nodes that presents in the given request and do not have any subnodes.

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
soap <endpoint> <request> --interactive -o output.xml --http1.0 -v
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

### Requirements

* `curl` 
* `xmllint` 
* `xmlstarlet`
* `GNU grep`

## Credits

* Followed guides from https://clig.dev/
* SOAP service used for testing: https://documenter.getpostman.com/view/8854915/Szf26WHn
* Testing framework: https://github.com/bats-core/bats-core
* Demo recorded with https://asciinema.org/
* Argument and option parsing generated with https://argbash.io/

