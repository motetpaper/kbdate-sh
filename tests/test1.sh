#!/usr/bin/env bash

PROG=$(basename $0)

msg (){
  echo "[$PROG] $1"
  echo
}

## test1 is a test of expected date input values
msg "test1 start
expected date time input values"

test___expected() {

  if [[ -z "$1" || -z "$2" ]]; then
    msg "test requires two arguments"
    msg "EXAMPLE:"
    msg "test___expected arg1 arg2"
    return
  fi

  msg "expected_value: $1"
  msg "test_value: $2"

  if [[ "$1" == "$2" ]];then
    echo "PASSED"
    return
  fi

  echo "FAILED"
}

## date only
expected_value="KB250305760"
test_value="2025-03-05"
msg "input format: YYYY-MM-DD"
msg "$ kbdate \"$test_value\""
test___expected "$expected_value" $(kbdate "$test_value")
echo
echo

expected_value="KB250305955"
test_value="2025-03-05 03:15:00"
msg "input format: YYYY-MM-DD HH:MM:SS"
msg "$ kbdate \"$test_value\""
test___expected "$expected_value" $(kbdate "$test_value")
echo
echo

## 24-hour time
expected_value="KB250306675"
test_value="2025-03-05 15:15:00"
msg "input format: YYYY-MM-DD HH:MM:SS"
msg "$ kbdate \"$test_value\""
test___expected "$expected_value" $(kbdate "$test_value")
echo
echo

## zero minutes have elapsed since the start of the month
expected_value="KB250100000"
test_value="2025-01-01 00:00:00"
msg "input format: YYYY-MM-DD HH:MM:SS"
msg "$ kbdate \"$test_value\""
test___expected "$expected_value" $(kbdate "$test_value")
echo
echo

## 44639 minutes have elapsed since the start of the month
expected_value="KB251244639"
test_value="2025-12-31 23:59:59"
msg "input format: YYYY-MM-DD HH:MM:SS"
msg "$ kbdate \"$test_value\""
test___expected "$expected_value" $(kbdate "$test_value")
echo
echo


msg "test1 complete"
