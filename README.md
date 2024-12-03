# weekly-planner
Small repository for generating weekly plans as advocated in [The 7 Habits of Highly Effective People](https://www.amazon.com/Habits-Highly-Effective-People-Powerful/dp/1982137274) by Stephen R. Covey

## Weekly Plans

This repository comes with an example weekly plan which may be tailored to suit your preferences. Of note, the capitalized weekday names which appear will be updated with formatted date strings.

> [!NOTE]
> The plans and scripts in this repository presume that weeks begin on Sunday and conclude on Saturday.

## Mission Statement

A personal mission statement should be defined prior to creating a weekly plan. While there are many valid formats, it can be helpful to begin by considering the various roles that you occupy in different contexts. An [example mission statement](./mission-statement.md) is included in this repository and should be updated to guide your own weekly planning.

## Scripts

To create a new weekly plan, run `scripts/create-new-plan.sh`

The script assumes that the plan is for the current week if the script is run on Sunday. When the script is run on other days you will be prompted to confirm whether the created plan is for the current week (if not, a plan will be generated for the following week).

### Environment Variables

- `DATE_FORMAT`: used with `date` utility to normalize formatted dates. Default is `"+%a %b %e %Y"`
