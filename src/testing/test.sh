#!/usr/bin/env bash

set +x

# Variables
TIMEOUT=2
NUMBER_OF_TESTS=0
NUMBER_OF_TESTS_FAILED=0


# Functions
count_failed_tests() {
	echo -e "Last command exitcode: $1"
	NUMBER_OF_TESTS=$(($NUMBER_OF_TESTS + 1))
	if [ $1 -gt 0 ]; then
		NUMBER_OF_TESTS_FAILED=$(($NUMBER_OF_TESTS_FAILED + 1))
	fi
}

test_ssh() {
	echo -e "\n----- Testing SSH access to $1 -----"
	nc -v -z -w ${TIMEOUT} $1:$2
	count_failed_tests $?
}

test_url() {
	echo -e "\n----- Testing URL $1 -----"
	curl --insecure --verbose --max-time ${TIMEOUT} --location ${1}
	count_failed_tests $?
}

display_results() {
	echo -e "\n\n----- ${NUMBER_OF_TESTS_FAILED} out of ${NUMBER_OF_TESTS} tests failed -----\n"
}


# Main
echo -e "\n\n\n\n-----------------------TEST BEGIN-----------------------"

test_ssh 1.2.3.4 22

test_url https://1.2.3.4:8443/

display_results

echo -e "------------------------TEST END------------------------"
