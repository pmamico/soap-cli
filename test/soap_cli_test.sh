#!/bin/bash
setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH"
    TEST_ENDPOINT="https://eio-soap-sample.herokuapp.com:443/ws"
    TEMP_OUTPUT="temp_out.xml"
}

get_version() {
    soap --help 2>&1 | grep cli | head -1
}

get_capital_of_spain() {
    soap "$TEST_ENDPOINT" "$DIR/spain_request.xml" | xml sel -t -v "//*[name()='ns2:capital']"
}

update_the_request_and_get_capital_of_poland() {
    soap  "$TEST_ENDPOINT" "$DIR/spain_request.xml" --update "//*[name()='sch:name']" --value "Poland" | xml sel -t -v "//*[name()='ns2:capital']"
}

interactive_mode_get_first_input() {
   echo | soap "$TEST_ENDPOINT" "$DIR/spain_request.xml" --interactive 2>&1
}

interactive_mode_with_oneliner_get_first_input() {
    echo "Hungary" | soap "$TEST_ENDPOINT" "$DIR/oneliner_request.xml" --interactive 2>&1
}

interactive_mode_send_input_Poland() {
    echo "Poland" | soap "$TEST_ENDPOINT" "$DIR/spain_request.xml" --interactive
}

curl_otpion_-o() {
    if test -f "$TEMP_OUTPUT"; then
        echo "$TEMP_OUTPUT already existed before testing."
        return
    fi
    soap "$TEST_ENDPOINT" "$DIR/spain_request.xml" -o "$TEMP_OUTPUT"
    if test -f "$TEMP_OUTPUT"; then
        echo "$TEMP_OUTPUT successfully created."
    fi
}

get_capital_from_output_file() {
    xml sel -t -v "//*[name()='ns2:capital']" "$TEMP_OUTPUT"
}

clean_up_temp_file() {
    rm "$TEMP_OUTPUT" 2>/dev/null
}

curl_otpion_--include() {
    soap "$TEST_ENDPOINT" "$DIR/spain_request.xml" --include
}

dry_run() {
    soap "$TEST_ENDPOINT" "$DIR/spain_request.xml" --dry
}

@test "version check" {
    run get_version
    assert_output "soap-cli v0.5"
}

@test "call elasticio's sample SOAP service with 'Spain' as country, expected response is 'Madrid'" {
    run get_capital_of_spain
    assert_output "Madrid"
}

@test '--interactive mode sanity check' {
    #skip
    run interactive_mode_get_first_input
    assert_output --partial "<sch:name>Spain</sch:name>"
}

@test '--interactive mode with non-formatted request' {
    run interactive_mode_with_oneliner_get_first_input
    assert_output --partial "<sch:name>Hungary</sch:name>"
}

@test 'update the request with --interactive mode ' {
    run interactive_mode_send_input_Poland
    assert_output --partial "REQUEST"
    assert_output --partial "<sch:name>Poland</sch:name>"
    assert_output --partial "RESPONSE"
    assert_output --partial "<ns2:capital>Warsaw</ns2:capital>"
}

@test "--update the request with --value 'Poland' instead of 'Spain', expected response is 'Warsaw'" {
    run update_the_request_and_get_capital_of_poland
    assert_output "Warsaw"
}

@test "use some curl options: -o output.xml, expected to send the output to the file" {
    run curl_otpion_-o
    assert_output "$TEMP_OUTPUT successfully created."
    run get_capital_from_output_file
    assert_output "Madrid"
    clean_up_temp_file
}


@test "use some curl options: --include, expected to include protocol response headers in the output" {
    run curl_otpion_--include
    assert_output --partial "HTTP/1.1 200"
}

@test "dry run, expected to print the command without execution" {
    run dry_run
    assert_output --partial "curl -s  --request POST"
}