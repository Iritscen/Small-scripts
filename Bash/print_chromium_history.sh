#!/bin/bash

# Print Chromium History
# Prints out the URLs visited on a given day by reading the history database of a Chromium-based browser.
# Parameters:
# 1: The path to the browser's history file. In Opera for Mac, this is ~/Library/Application Support/
#    com.operasoftware.Opera/History.
# 2: The year for the history lookup.
# 3: The month for the history lookup.
# 4: The day for the history lookup.
# 5. The time zone offset. Chromium's timestamps are shifted by your offset from UTC, so you should plug in
#    the reverse of your offset, e.g. if you are in ET (UTC-05:00), supply "5" as the offset.
# Known bugs: Sometimes a time offset is necessary to get the correct 24-hour period, and sometimes it isn't.
# Recommended rule:
# |---------------------------------------------------------------------------------------------------------|

IFS="
"

HISTORY_PATH="$1"
HUMAN_YEAR=$2
HUMAN_MONTH=$3
HUMAN_DAY=$4
TZ_OFFSET=$5

##SAFETY CHECKS##
if [ ! -f "$1" ]; then
   echo "History file not found at path $1. Exiting."
   exit
fi

if [ -z $HUMAN_YEAR ] || [ $HUMAN_YEAR -lt 1 ] || [ $HUMAN_YEAR -gt 9999 ]; then
   echo "Year out of expected range of 1 AD-9,999 AD! Exiting."
   exit
fi

if [ -z $HUMAN_MONTH ] || [ $HUMAN_MONTH -lt 1 ] || [ $HUMAN_MONTH -gt 12 ]; then
   echo "Month out of expected range of 1-12! Exiting."
   exit
fi

if [ -z $HUMAN_DAY ] || [ $HUMAN_DAY -lt 1 ] || [ $HUMAN_DAY -gt 31 ]; then
   echo "Day out of expected range of 1-31! Exiting."
   exit
fi

if [ -z $TZ_OFFSET ]; then
   TZ_OFFSET=0
fi

## TIME UTILITIES ##
# Converts a raw date, as stored on disk by Chromium-based browsers, to a human-readable one. The input to
# this function should be a number 17 digits long, and around 13 quadrillion, e.g. 13180923665109490 for
# a time on Sep. 8, 2018 AD
function chrome_time_to_human_time()
{
   SEARCH_DATE=$1

   # Difference between bases of Unix epoch and Chrome epoch, which is 1601 AD for some reason
   let UNIX_CHROME_YEAR_DIFF=1970-1601

   # Convert to seconds, since Chrome time is in microseconds for some reason
   let UNIX_DATE=$SEARCH_DATE/1000000

   # Get human time
   NICE_DATE=$(date -r $UNIX_DATE -v -${UNIX_CHROME_YEAR_DIFF}y "+%Y-%m-%d %H-%M-%S")

   # Same, but apply a time zone
   #NICE_DATE=$(TZ=":UTC" date -r $UNIX_DATE -v -${UNIX_CHROME_YEAR_DIFF}y "+%Y-%m-%d %H-%M-%S")

   echo $NICE_DATE
}

# It is a leap year if the year is divisible by 4, unless it is also divisible by 100, unless it is ALSO
# divisible by 400
function isLeapYear()
{
   addOne=0
   if [ $(($1 % 4)) -eq 0 ]; then
      addOne=1
      if [ $(($1 % 100)) -eq 0 ]; then
         addOne=0
         if [ $(($1 % 400)) -eq 0 ]; then
            addOne=1 # stop toying with my heart
         fi
      fi
   fi

   echo $addOne
}

# Returns number of days that passed from 1601 AD through the year before the one passed in as the sole
# parameter
function getDaysBeforeYearX()
{
   sumDays=0
   curYear=$1
   while [ $curYear -gt $CHROME_EPOCH_YEAR ]; do
      let sumDays+=365
      let sumDays+=$(isLeapYear $(($curYear-1)))
      let curYear-=1
   done
   echo $sumDays
}

# Returns number of days that passed from Jan. 1 through the end of the month before the one passed in as
# the first parameter. You must pass in the year as the second parameter so we can tell how many days Feb.
# has.
function getDaysBeforeMonthXInYearY()
{
   sumDays=0
   curMonth=$1
   declare -a MONTH_DAYS=(31 28 31 30 31 30 31 31 30 31 30 31)

   # As long as we are looking back no further than Jan., look up the days
   # in the month before this one
   while [ $curMonth -gt 1 ]; do
      let sumDays+=MONTH_DAYS[$(($curMonth-2))]
      # If we are looking back to Feb., adjust for possible leap day
      if [ $curMonth -eq 3 ]; then
         let sumDays+=$(isLeapYear $2)
      fi
      let curMonth-=1
   done
   echo $sumDays
}

# Converts a human-style date, passed as the parameters "year month day", to the format that Chromium-based
# browsers store on disk in their records.
function human_time_to_chrome_time()
{
   SEARCH_YEAR=$1
   SEARCH_MONTH=$2
   SEARCH_DAY=$3

   CHROME_EPOCH_YEAR=1601
   CHROME_EPOCH_MONTH=1
   CHROME_EPOCH_DAY=1

   # Size of an hour in Chrome time (60m * 60s * 1,000,000µs)
   HOUR_SIZE=3600000000

   # Normalize to Chrome epoch
   let YEAR_DIFF=$SEARCH_YEAR-$CHROME_EPOCH_YEAR
   let MONTH_DIFF+=$SEARCH_MONTH-$CHROME_EPOCH_MONTH
   let DAY_DIFF+=$SEARCH_DAY-$CHROME_EPOCH_DAY

   # Convert it all to days
   YEAR_DIFF_DAYS=$(getDaysBeforeYearX $SEARCH_YEAR)
   MONTH_DIFF_DAYS=$(getDaysBeforeMonthXInYearY $SEARCH_MONTH $SEARCH_YEAR)

   # Convert it all to seconds
   let DAY_DIFF_SEC=$DAY_DIFF*24*60*60
   let MONTH_DIFF_SEC=$MONTH_DIFF_DAYS*24*60*60
   let YEAR_DIFF_SEC=$YEAR_DIFF_DAYS*24*60*60

   # Convert it all to microseconds
   let CHROME_TIME=$DAY_DIFF_SEC+$MONTH_DIFF_SEC+$YEAR_DIFF_SEC
   let CHROME_TIME*=1000000

   # Adjust for time zone and return the Chrome time
   let CHROME_TIME+=$(($TZ_OFFSET*$HOUR_SIZE))
   echo $CHROME_TIME
}

## MAIN FUNCTION ##
echo Showing activity for date $HUMAN_YEAR-$HUMAN_MONTH-$HUMAN_DAY...

# Size of a day in Chrome time (24h * 60m * 60s * 1,000,000µs)
DAY_SIZE=86400000000

# Get start and end of desired day in Chrome time
CHROME_DAY=$(human_time_to_chrome_time $HUMAN_YEAR $HUMAN_MONTH $HUMAN_DAY)
let CHROME_DAY_PLUS_ONE=$CHROME_DAY+$DAY_SIZE

for RECORD in `sqlite3 "$HISTORY_PATH" 'SELECT url,visit_time FROM ( SELECT * FROM visits WHERE visit_time > '$CHROME_DAY' ) WHERE visit_time < '$CHROME_DAY_PLUS_ONE' ORDER BY visit_time DESC;'`; do
   URL_ID=`echo $RECORD | cut -d '|' -f 1`
   CHROME_DATE=`echo $RECORD | cut -d '|' -f 2`
   HUMAN_DATE=$(chrome_time_to_human_time $CHROME_DATE)
   THE_URL=$(sqlite3 "$HISTORY_PATH" 'SELECT url FROM urls WHERE id = '$URL_ID';')
   echo $HUMAN_DATE: $THE_URL
done