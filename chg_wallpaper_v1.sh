#!/bin/bash	

################
# Author: Aditya Vinchhi
# Note: This scrpit only works for ubuntu 22.00 or above. 
################

export DISPLAY=:0;
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus


get_curr_theme() {

	local curr_theme=$(gsettings get org.gnome.desktop.interface color-scheme);
	local curr_theme=$(echo "$curr_theme" | tr -d \');
	
	echo $curr_theme;
}

set_background() {
	
	local img_path=$1;
	local curr_theme=$2;

	if [ $curr_theme = "prefer-dark" ]; then
		gsettings set org.gnome.desktop.background picture-uri-dark file://$img_path
	else
		gsettings set org.gnome.desktop.background picture-uri file://$img_path
	fi
}

get_background_img_name() {
	local curr_theme=$1;
	
	if [ $curr_theme = "prefer-dark" ]; then
		local curr_img_path=$(gsettings get org.gnome.desktop.background picture-uri-dark);

	else
		local curr_img_path=$(gsettings get org.gnome.desktop.background picture-uri);
	fi


	local curr_img_path=$(echo "$curr_img_path" | tr -d \');

	local img_name=$(basename "$curr_img_path");

	echo $img_name;

}


next_img_name() {
	local curr_img_name=$1;
	local img_dir_path=$2;
	shopt -s nullglob;
	local img_paths=("$img_dir_path"/*.{jpg,png,jpeg});
	local img_len=${#img_paths[*]}

	for index in "${!img_paths[@]}"; do
		local nex_img_name=$(basename "${img_paths[$index]}")
		if [ "$nex_img_name" = "$curr_img_name" ]; then
			local res="${img_paths[(($index + 1) % $img_len)]}"
			echo "$(basename $res)"
			return
		fi
	done

	local res=$(basename "${img_paths[0]}")
	echo "$res"
}


curr_theme=$(get_curr_theme);
cur_bg_img=$(get_background_img_name $curr_theme);

# add current wallpaper folder.
img_dir_path="/home/developer/Pictures/Wallpapers"
next_bg_img=$(next_img_name $cur_bg_img $img_dir_path);

echo "$curr_theme";
echo "$next_bg_img";

next_bg_img_path="$img_dir_path/$next_bg_img";
$(set_background $next_bg_img_path $curr_theme);







