#!/bin/bash

# Created by Dan Roth
# Date: 20-04-2018
# -
# Parses the output of the Google Play Music Desktop Player JSON file and displays it as i3blocks widget.

JP="$HOME/.config/gpmdp/json_store/playback.json"
STEPS="10"

progress_bar () {
  # Get length of song in ms
  LEN=$(jq -r .time.total "$JP")
  # Get position in song
  POS=$(jq -r .time.current "$JP")
  # Calculate number of hashtags
  HST=$(echo "(($POS)/($LEN/$STEPS))+1" | bc)
  # Calculate number of fillers
  FIL=$(echo "($STEPS-$HST)" | bc)
  # Don't show any progress if position is zero
  if [[ "$POS" -eq "0"  ]]
  then
    HST=0
  else
  # Otherwise 
    PRG=$(head -c "$HST" < /dev/zero | tr '\0' '#')
  fi  
  TOT=$(head -c "$FIL" < /dev/zero | tr '\0' '-')
  echo " - [$PRG$TOT]"
}

main () {
OUT=""
if [[ $(jq .song.title "$JP") == "null" ]]
then
  echo "0"
  exit 1
else 
  ART=$(jq -r .song.artist "$JP")
  TIT=$(jq -r .song.title "$JP")
  OUT+="$ART - $TIT"
fi
BAR=$(progress_bar)
OUT+=$(progress_bar)

echo $OUT
}

main
