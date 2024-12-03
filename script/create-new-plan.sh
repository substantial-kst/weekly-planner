#!/usr/bin/env bash
#
# Usage: create-new-plan.sh

project_dir=$(dirname $0 | sed "s|/script||g")

prompt-current-week-plan() {
  read -p "Is this plan for the current week? (yY/nN)" plan_for_current_week

  if [[ ! $plan_for_current_week =~ ^[yYnN]{1}$ ]]; then
    plan_for_current_week=$(prompt-current-week-plan)
  fi

  if [[ $plan_for_current_week =~ ^[yY]{1}$ ]]; then
    plan_week="current"
  else
    plan_week="next"
  fi

  echo $plan_week
}

day_of_week=$(date "+%w") # Sunday = 0

if [[ $day_of_week != "0" ]]; then
  plan_week=$(prompt-current-week-plan)
  if [[ $plan_week == "next" ]]; then
    week_offset="1"
  fi
fi

current_time_seconds=$(date +%s)
start_of_week=$(source $(dirname $0)/get-start-of-week.sh $week_offset)

get-week-day() {
  day_offset=$1

  plan_start_seconds=$(date -j -f "%Y-%m-%d" "$start_of_week" +%s)
  diff=$((plan_start_seconds - current_time_seconds))

  day_diff=$((diff / 86400))
  offset=$((day_offset + day_diff))

  if [[ ! $offset =~ ^\- ]]; then
    offset="+$offset"
  fi

  date_format=$DATE_FORMAT
  if [[ -z $date_format ]]; then
    date_format="+%a %b %e %Y"
  fi

  suffix="d"
  echo $(date -v$offset$suffix "$date_format")
}

sun=$(get-week-day 0)
mon=$(get-week-day 1)
tue=$(get-week-day 2)
wed=$(get-week-day 3)
thu=$(get-week-day 4)
fri=$(get-week-day 5)
sat=$(get-week-day 6)

example_plan_path="$project_dir/plans/example.md"

temp_file=$(mktemp)

# Replace each instance of weekday in the plan with the date format
while IFS= read -r line; do
  updated_line=$(echo "$line" | sed -e "s/Sunday/${sun}/g" -e "s/Monday/${mon}/g" -e "s/Tuesday/${tue}/g" -e "s/Wednesday/${wed}/g" -e "s/Thursday/${thu}/g" -e "s/Friday/${fri}/g" -e "s/Saturday/${sat}/g")
  # Write the updated line to the temporary file
  echo "$updated_line" >> "$temp_file"
done < "$example_plan_path"

filename=$project_dir/plans/$start_of_week
filename+=".md"

mv "$temp_file" "$filename"
