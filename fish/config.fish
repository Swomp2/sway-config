if status is-login
   	export PATH="$PATH:/var/lib/flatpak/exports/bin"
	export PATH="$PATH:/usr/local/libexec"
   	export QT_QPA_PLATFORM="wayland"
	export XDG_CURRENT_DESKTOP="sway"
	export QT_QPA_PLATFORMTHEME="qt5ct"
	exec dbus-launch --exit-with-session sway
end


alias reboot="doas reboot"
alias poweroff="doas poweroff"

function fish_prompt
	 set_color "#a3be8c"
	 echo '['$USER'|'$hostname (set_color "#5e81ac")(pwd)(set_color "#a3be8c")']'(set_color "#a3be8c")'==['(set_color normal) 
end

function fish_greeting
end
