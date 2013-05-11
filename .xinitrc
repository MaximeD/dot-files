setxkbmap fr -variant oss &
nitrogen --restore &
synclient TapButton1=1 &
urxvtd &
mocp -S

# dual screen
# xrandr --output VGA-1 --left-of LVDS-1 --output VGA-1 --auto --output LVDS-1 --auto


# exec ck-launch-session dbus-launch enlightenment_start
exec ck-launch-session dbus-launch awesome
# exec ck-launch-session dbus-launch /opt/bin/VirtualBox -startvm "winXP"
# exec ck-launch-session dbus-launch startfluxbox
