#!/bin/bash
setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    TEST_ENDPOINT="https://www.dataaccess.com/webservicesserver/NumberConversion.wso"
    TEMP_OUTPUT="temp_out.xml"
}

get_version() {
    "$DIR"/../src/soap --help 2>&1 | grep cli | head -1
}

get_response_value() {
    "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" | xml sel -t -v "//*[name()='m:NumberToDollarsResult']"
}

update_the_request_and_get_response_value() {
    "$DIR"/../src/soap  "$TEST_ENDPOINT" "$DIR/request.xml" --update "//*[name()='dNum']" --value "100" | xml sel -t -v "//*[name()='m:NumberToDollarsResult']"
}

interactive_mode_get_first_input() {
   echo | "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" --interactive 2>&1
}

interactive_mode_with_oneliner_get_first_input() {
    echo "100" | "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/oneliner_request.xml" --interactive 2>&1
}

interactive_mode_send_input_576() {
    echo "576" | "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" --interactive
}

curl_otpion_-o() {
    if test -f "$TEMP_OUTPUT"; then
        echo "$TEMP_OUTPUT already existed before testing."
        return
    fi
    "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" -o "$TEMP_OUTPUT"
    if test -f "$TEMP_OUTPUT"; then
        echo "$TEMP_OUTPUT successfully created."
    fi
}

get_response_from_output_file() {
    xml sel -t -v "//*[name()='m:NumberToDollarsResult']" "$TEMP_OUTPUT"
}

clean_up_temp_file() {
    rm "$TEMP_OUTPUT" 2>/dev/null
}

curl_otpion_--include() {
    "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" --include
}

dry_run() {
    "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" --dry
}

pretty_print() {
    "$DIR"/../src/soap "$TEST_ENDPOINT" "$DIR/request.xml" --pretty --dry
}

@test "version check" {
    run get_version
    assert_output "soap-cli v1.2"
}

@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml"' {
    run get_response_value
    assert_output "five hundred dollars"
}

@test 'echo | src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" --interactive' {
    #skip
    run interactive_mode_get_first_input
    assert_output --partial "<dNum>500</dNum>"
}

@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/oneliner_request.xml" --interactive' {
    run interactive_mode_with_oneliner_get_first_input
    assert_output --partial "<dNum>100</dNum>"
}

@test 'echo "576" | src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" --interactive' {
    run interactive_mode_send_input_576
    assert_output --partial "REQUEST"
    assert_output --partial "<dNum>576</dNum>"
    assert_output --partial "RESPONSE"
    assert_output --partial "<m:NumberToDollarsResult>five hundred and seventy six dollars</m:NumberToDollarsResult>"
}

@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" --update "//*[name\(\)="dNum"]" --value "100"' {
    run update_the_request_and_get_response_value
    assert_output "one hundred dollars"
}

@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" -o "temp_out.xml"' {
    run curl_otpion_-o
    assert_output "$TEMP_OUTPUT successfully created."
    run get_response_from_output_file
    assert_output "five hundred dollars"
    clean_up_temp_file
}


@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" --include' {
    run curl_otpion_--include
    assert_output --partial "HTTP/2 200"
}

@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" --dry' {
    run dry_run
    assert_output --partial "curl -s  --request POST"
}


@test 'src/soap "https://www.dataaccess.com/webservicesserver/NumberConversion.wso" "test/request.xml" --dry --pretty' {
    run pretty_print
    assert_output --partial "syntax=xml"
}
