#! /usr/bin/env bash
#
# Usage: get-start-of-week.sh [WEEK_OFFSET_COUNT]
week_offset_count=$(echo $1|tr -d " ")

build_offset() {
  local suffix="$1"
  local count="$2"

  if [[ ! $count =~ ^-?[0-9]+$ ]]; then
    # Only integers are supported
    exit 1
  else
    offset="-v"

    if [[ ! $count =~ ^- ]]; then
      offset+="+"
    fi

    offset+="$count$suffix"
  fi

  echo $offset
}

if [[ ! -z $week_offset_count ]]; then
  week_offset=$(build_offset "w" $week_offset_count)
  if [[ $? == 1 ]]; then
    echo "Error: Argument must be an integer"
    echo "Usage: get-start-of-week.sh [WEEK_OFFSET_COUNT]"
    exit 1
  fi
fi

current_day=$(date "+%w")
day_offset=$(build_offset "d" "-$current_day")

date_format="+%Y-%m-%d"
sunday=$(date $day_offset $week_offset $date_format)

echo $sunday
