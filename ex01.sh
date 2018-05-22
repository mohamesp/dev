#!/bin/bash
most_recent_release=$(git describe --tags --match 'TAG-*_TC*' --abbrev=0)
printf "Extracting user stories and defects since last release %s" "${most_recent_release}"
git_diff_stories_defects=$(git log "$most_recent_release"..HEAD | cut -d' ' -f2- | grep -iE '\[[US|DE]+[0-9].*\]' -0 | awk -F'[][]' '{print $2}' | tr "[a-z]" "[A-Z]" | sort -u | tr '\n' ',')
OIFS=$IFS
IFS=","
rally_array_all=(${git_diff_stories_defects%?})
printf "\n%s" "$rally_array_all"
