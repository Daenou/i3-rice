#!/bin/bash


echo "Installing prerequisites..."
sudo apt-get -y install i3 i3blocks i3lock rofi compton jq scrot

echo "Creating symbolic link for Google Play Music Desktop Player..."

GPPATH="$HOME/.config/gpmdp"
I3CFG="$HOME/.config/i3/config"
I3BCFG="$HOME/.config/i3/i3blocks.conf"
FONTPATH="$HOME/.fonts"
SCRIPTPATH="$HOME/scripts"

if ! [ -L "$GPPATH" ]
then
  echo "Creating symbolic link for gpmdp..."
  ln --symbolic "$HOME/.config/Google Play Music Desktop Player/" "$HOME/.config/gpmdp/"
else
  echo "Symbolic link already exists..."
fi


if ! [ -e "$I3CFG" ]
then
  echo "Copying i3 config file..."
  cp ./.config/i3/config "$I3CFG"
else
  while true; do
    read -p "An i3 config already exists, overwrite? [y,n]: " yn
    case $yn in
      [Yy]) cp ./.config/i3/config "$I3CFG"; break;;
      [Nn]) break;;
      *) echo "Please answer 'y' or 'n'."
    esac
  done
fi

if ! [ -e "$I3BCFG" ]
then
  echo "Copying i3-Blocks config file..."
  cp ./.config/i3/i3blocks.conf "$I3BCFG"
else
  while true; do
    read -p "An i3-Blocks config already exists, overwrite? [y,n]: " yn
    case $yn in
      [Yy]) cp ./.config/i3/i3blocks.conf "$I3BCFG"; break;;
      [Nn]) break;;
      *) echo "Please answer 'y' or 'n'."
    esac
  done
fi


echo "Installing FontAwesome..."

if ! [ -d "$FONTPATH" ]
then
  mkdir "$FONTPATH"
  wget "https://use.fontawesome.com/releases/v5.0.10/fontawesome-free-5.0.10.zip"
  unzip fontawesome-free-5.0.10.zip
  cp ./fontawesome-free-5.0.10/use-on-desktop/*.otf "$FONTPATH/"
  rm -r fontawesome-free-5.0.10*
else
  if ! [ -e "$FONTPATH/Font Awesome 5 Brands-Regular-400.otf" ]
  then
    wget "https://use.fontawesome.com/releases/v5.0.10/fontawesome-free-5.0.10.zip"
    unzip fontawesome-free-5.0.10.zip
    cp ./fontawesome-free-5.0.10/use-on-desktop/*.otf "$FONTPATH/"
    rm -r fontawesome-free-5.0.10*
  fi
  echo "Font Awesome is already installed."
fi


echo "Installing scripts..."
if ! [ -d "$SCRIPTPATH" ]
then
  cp -r ./scripts $HOME
else
  if ! [ -f "$SCRIPTPATH/gpmdp_i3.sh" ]
  then
    cp .scripts/gpmdp_i3.sh "$SCRIPTPATH/"
  fi
  if ! [ -f "$SCRIPTPATH/lock.sh" ]
  then
    cp .scripts/lock.sh "$SCRIPTPATH/"
  fi
fi

echo "Reloading i3..."
i3-msg restart
