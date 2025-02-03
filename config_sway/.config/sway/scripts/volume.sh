#!/usr/bin/env bash

get_volume(){
    pamixer --get-volume-human
}

volume_up(){
    pamixer --allow-boost --set-limit 150 -i 5
}

volume_down(){
    pamixer --allow-boost --set-limit 150 -d 5
}

toggle_mute(){
    pamixer --toggle-mute
}

toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m && dunstify --replace=11111 -a 'no' "Microphone Switched OFF"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer --default-source -u && dunstify --replace=11111 -a 'no' "Microphone Switched ON"
	fi
}

notify_cmd(){ 
    dunstify --replace=11111 -a 'no' --hints=int:value:"$(get_volume)" "🔊 Volume: $(get_volume)"
}

case "$1" in
	--up) volume_up
        notify_cmd ;;
	--down) volume_down
            notify_cmd ;;
	--toggle) toggle_mute
            notify_cmd ;;
	--toggle_mic) toggle_mic;;
esac
