#!/bin/bash

# HTTP Tests
# Prints a specified type of response to an HTTP query on a specified URL.
# Parameter 1: Desired type of response to obtain. Allowed types are:
#    "code": HTTP response code (status)
#    "header": HTTP header
#    "redirect": Redirect URL returned for this URL
#    "archive": Internet Archive response code (whether this page is archived)
# Parameter 2: The URL to test.
# Recommended width:
# |----------------------------------------------------------------------------------------------------------------------------------------|

IFS="
"

if [ "$#" -ne 2 ]; then
   echo "You need to supply two parameters: a mode argument (\"code\", \"header\", \"redirect\", or \"archive\") and then a URL to test."
   exit 1
fi

MODE=0
CURL_AGENT="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:53.0) Gecko/20100101 Firefox/53.0"
CURL_URL=$2

case "$1" in
   code )     MODE=1; shift;;
   header )   MODE=2; shift;;
   redirect ) MODE=3; shift;;
   archive )  MODE=4; shift;;
   * )        echo "Invalid mode argument '$1' detected. Aborting."; exit 2;;
esac

if [ $MODE -eq 1 ]; then
   curl -o /dev/null --silent --insecure --head --user-agent '$CURL_AGENT' --write-out '%{http_code}\n' $CURL_URL
elif [ $MODE -eq 2 ]; then
   curl --silent --insecure --head --user-agent '$CURL_AGENT' $CURL_URL
elif [ $MODE -eq 3 ]; then
   curl -o /dev/null --silent --insecure --head --user-agent '$CURL_AGENT' --max-time 10 --write-out '%{redirect_url}\n' $CURL_URL
elif [ $MODE -eq 4 ]; then
   curl --silent --max-time 10 "http://archive.org/wayback/available?url=$CURL_URL&statuscodes=200&statuscodes=203&statuscodes=206"
   echo
fi