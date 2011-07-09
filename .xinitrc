#############################################
# divers et généralités
#############################################
export XDG_MENU_PREFIX=gnome-
setxkbmap fr -variant oss &      # pour les caractères accessibles avec altgr
nitrogen --restore &
synclient TapButton1=1 &


exec ck-launch-session dbus-launch enlightenment_start
#exec ck-launch-session dbus-launch gnome-session
#exec ck-launch-session dbus-launch awesome
#exec ck-launch-session dbus-launch /opt/bin/VirtualBox -startvm "winXP"