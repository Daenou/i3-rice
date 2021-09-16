#!/bin/bash


if [ -d "./files" ]
then
  cd ./files
else
  echo "ERROR: ./files directory doesn't exist, are you executing this script from the right path?"
  exit 1
fi

echo "Installing prerequisites..."
sudo apt-get -y install i3 i3blocks i3lock rofi compton jq scrot

I3CFG="$HOME/.config/i3/config"
I3BCFG="$HOME/.config/i3/i3blocks.conf"
XRSC="$HOME/.Xresources"
FONTPATH="$HOME/.fonts"
SCRIPTPATH="$HOME/scripts"
X11CFGDIR="/etc/X11/xorg.conf.d/"

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

if ! [ -e "$XRSC" ]
then
  echo "Copying Xresources config file..."
  cp ./Xresources "$XRSC"
else
  while true; do
    read -p "An Xresources config already exists, overwrite? [y,n]: " yn
    case $yn in
      [Yy]) cp ./Xresources "$XRSC"; break;;
      [Nn]) break;;
      *) echo "Please answer 'y' or 'n'."
    esac
  done
fi

if ! [ -d "$X11CFGDIR" ]
then
  echo "Creating $X11CFGDIR and copying touchpad config file..."
  mkdir "$X11CFGDIR"
  cp ./90-touchpad.conf "$X11CFGDIR"
else
  if ! [ -e "$X11CFGDIR/90-touchpad.conf" ]
  then
    cp ./90-touchpad.conf "$X11CFGDIR"
  else
    while true; do
      read -p "A 90-touchpad.conf already exists in $X11CFGDIR, overwrite? [y,n]: " yn
      case $yn in
        [Yy]) cp ./90-touchpad.conf "$X11CFGDIR"; break;;
        [Nn]) break;;
        *) echo "Please answer 'y' or 'n'."
      esac
    done
  fi
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


#echo "Installing scripts..."
#if ! [ -d "$SCRIPTPATH" ]
#then
#  cp -r ./scripts $HOME
#else
#  if ! [ -f "$SCRIPTPATH/gpmdp_i3.sh" ]
#  then
#    cp .scripts/gpmdp_i3.sh "$SCRIPTPATH/"
#  fi
#fi

echo "Reloading i3..."
i3-msg restart

echo "Please logout and login to apply the X11 config"
echo "Enjoy!"
