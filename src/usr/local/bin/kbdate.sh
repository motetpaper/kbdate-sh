#!/usr/bin/env bash

##
## kbdate.sh
## job  : generates new knowledgebase identifier
## git  : https://github.com/motetpaper/kbdate-sh
## lic  : MIT
## NOTE : KBYYMMmmmmm (kbdate)
##

## helps track tricky timezones
TZ=$(timedatectl | grep "zone" | cut -f 2 -d ':'  | cut -f 1 -d '(' | tr -d [:space:])

## this is a reminder that the expected
## value is an integer, not a formatted date
indate=0

if [[ -z $1 ]]; then
  indate=$(date +"%s")
else
  ## if the user input date is invalid,
  ## then, then the fallback date is the default date
  indate=$(date --date="$1" +"%s" || date +"%s")
fi

## now
t1=$(date --date="@$indate" +"%s")

## date formats
YYYY=$(date --date="@$indate" +"%Y")
YY=$(date --date="@$indate" +"%y")
MM=$(date --date="@$indate" +"%m")

## new month begins
t0=$(date --date="$YYYY-$MM-01 00:00:00" +"%s")

## seconds between elapsed in month
diff=$((t1-t0)) # units of seconds

## minutes elapsed in month
m=$((diff/60)) # units of minutes

## five-digit number of minutes
## expecting values between 00000 and 44639
mmmmm=$(printf "%05d" $m)

## final string
kbdate="KB"$YY$MM$mmmmm

echo $kbdate
