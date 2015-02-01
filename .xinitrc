setxkbmap fr -variant oss &
numlockx on &
xcompmgr &
mocp -S &
volumeicon &
urxvtd --quiet --fork &
exec ck-launch-session dbus-launch awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
