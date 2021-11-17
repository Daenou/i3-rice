# i3-rice

This is my simple i3 rice using i3 tiling window manager, i3blocks for the status bar and rofi for starting applications.
It also has some more dependencies such as brightnessctl and pulsemixer for the handling of the media and function keys.

Tested on my Lenovo X390 with Ubuntu 20.04 LTS installed.

The rice comes with a simple ansible install playbook which does the following tasks:
- Installs the necessary dependencies via apt or snap
- Installs the default configuration files in ./files
- Adds necessary sudoers configuration for passwordless execution for brightnessctl
- Adds and enables the suspend@$USERID systemd service to lock the screen after waking uf from sleep

To use the playbook please:
- Install ansible `sudo apt install ansible`
- First execute the playbook with --check and --diff to show the changes `ansible-playbook install.yml --check --diff -K`
- Then execute the playbook without --check `ansible-playbook install.yml -diff -K"

Enjoy.

Note: This is not perfect, please create issues/pull requests for issues you might encounter.
