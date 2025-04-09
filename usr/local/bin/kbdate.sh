#!/usr/bin/env bash
##
## kbdate.sh
## job  : generates new knowledgebase identifier
## git  : https://github.com/motetpaper/kbdate-sh
## lic  : MIT
##

## helps track tricky timezones
TZ=$(timedatectl | grep "zone" | cut -f 2 -d ':'  | cut -f 1 -d '(' | tr -d [:space:])

indate=0

if [[ -z $1 ]]; then
  indate=$(date +"%s")
else
  indate=$(date --date="$1" +"%s")
fi

## now
t1=$(date --date="@$indate" +"%s")

## date formats
yyyy=$(date --date="@$indate" +"%Y")
yy=$(date --date="@$indate" +"%y")
mm=$(date --date="@$indate" +"%m")

## new month begins
t0=$(date --date="$yyyy-$mm-01 00:00:00" +"%s")

## seconds between elapsed in month
diff=$((t1-t0))

## hours elapsed in month
h=$((diff/3600))

## three-digit leading zero
hhh=$(printf "%03d" $h)

## final string
kbdate="KB"$yy$mm$hhh

echo $kbdate
