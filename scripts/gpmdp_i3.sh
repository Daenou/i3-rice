#!/bin/bash

# Created by Dan Roth
# Date: 20-04-2018
# -
# Parses the output of the Google Play Music Desktop Player JSON file and displays it as i3blocks widget.

JP="$HOME/.config/gpmdp/json_store/playback.json"

progress_bar () {
  LEN=$(jq -r .time.total "$JP")
  POS=$(jq -r .time.current "$JP")
  HST=$(echo "(($POS)/($LEN/10))+1" | bc)
  FIL=$(echo "(10-$HST)" | bc)
  PRG=$(head -c "$HST" < /dev/zero | tr '\0' '#')
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
