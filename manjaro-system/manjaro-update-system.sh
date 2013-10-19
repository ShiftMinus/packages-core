
err() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    RED="${BOLD}\e[1;31m"
	local mesg=$1; shift
	printf "${RED}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

msg() {
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    GREEN="${BOLD}\e[1;32m"
	local mesg=$1; shift
	printf "${GREEN}==>${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

check_pkgs()
{
	local remove=""

    for pkg in ${packages} ; do
        for rmpkg in $(pacman -Qq | grep ${pkg}) ; do
            if [ "${pkg}" == "${rmpkg}" ] ; then
               removepkgs="${removepkgs} ${rmpkg}"
            fi
        done
    done

    packages="${removepkgs}"
}

detectDE()
{
    if [ x"$KDE_FULL_SESSION" = x"true" ]; then DE=kde;
    elif [ x"$GNOME_DESKTOP_SESSION_ID" != x"" ]; then DE=gnome;
    elif `dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.GetNameOwner string:org.gnome.SessionManager > /dev/null 2>&1` ; then DE=gnome;
    elif xprop -root _DT_SAVE_MODE 2> /dev/null | grep ' = \"xfce4\"$' >/dev/null 2>&1; then DE=xfce;
    elif [ x"$DESKTOP_SESSION" = x"LXDE" ]; then DE=lxde;
    else DE=""
    fi
}

post_upgrade() {

	# remove pyc-files if python-gobject < 3.10.1
	pacman -Qq python-gobject &> /tmp/cmd1
	pacman -Q python-gobject &> /tmp/cmd2
	if [ "$(grep 'python-gobject' /tmp/cmd1)" == "python-gobject" ]; then
	   if [ "$(cat /tmp/cmd2 | cut -d- -f2 | cut -d" " -f2 | sed -e 's/\.//g')" -lt "3101" ]; then
		msg "Fixing python-gobject ..."
		# System operation
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/__init__.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/__init__.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/docstring.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/docstring.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/importer.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/importer.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/module.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/module.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/pygtkcompat.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/pygtkcompat.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/types.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/__pycache__/types.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/_glib/__pycache__/__init__.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/_glib/__pycache__/__init__.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/_glib/__pycache__/option.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/_glib/__pycache__/option.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/__init__.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/__init__.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/constants.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/constants.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/propertyhelper.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/propertyhelper.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/signalhelper.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/_gobject/__pycache__/signalhelper.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/GIMarshallingTests.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/GIMarshallingTests.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/GLib.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/GLib.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/GObject.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/GObject.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Gdk.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Gdk.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Gio.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Gio.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Gtk.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Gtk.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Pango.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/Pango.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/__init__.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/__init__.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/keysyms.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/overrides/__pycache__/keysyms.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/gi/repository/__pycache__/__init__.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/gi/repository/__pycache__/__init__.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/pygtkcompat/__pycache__/__init__.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/pygtkcompat/__pycache__/__init__.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/pygtkcompat/__pycache__/generictreemodel.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/pygtkcompat/__pycache__/generictreemodel.cpython-33.pyo
		rm -f /usr/lib/python3.3/site-packages/pygtkcompat/__pycache__/pygtkcompat.cpython-33.pyc
		rm -f /usr/lib/python3.3/site-packages/pygtkcompat/__pycache__/pygtkcompat.cpython-33.pyo
		rm /var/lib/pacman/db.lck &> /dev/null
		pacman --noconfirm -Sdd python-gobject &> /dev/null
	   fi
	fi

	# add mate repo when missed in pacman.conf
	if [ -e "/usr/bin/mate-session" ] && [ "$(grep '\[mate\]' /etc/pacman.conf)" == "" ]; then
		msg "Adding MATE repository ..."
		echo "[mate]" >> /etc/pacman.conf
		echo "# Official MATE repo:" >> /etc/pacman.conf
		echo "SigLevel = Never" >> /etc/pacman.conf
		echo 'Server = http://repo.mate-desktop.org/archlinux/$arch' >> /etc/pacman.conf
	fi

	# fix broken mate repo entry
	if [ -e "/usr/bin/mate-session" ] && [ "$(grep 'repo.mate-desktop.org/archlinux/\$arch' /etc/pacman.conf)" == "" ]; then
		msg "Fixing MATE repository entry ..."
		sed -i 's|repo.mate-desktop.org/archlinux/|repo.mate-desktop.org/archlinux/$arch|g' /etc/pacman.conf
	fi

	# depreciate sysctl.conf
	if [ "$(vercmp $2 20130921-1)" -lt 0 ] && [ -f /etc/sysctl.conf ]; then
		msg "Depreciate sysctl.conf ..."
		if [ -f /etc/sysctl.d/99-sysctl.conf ]; then
			mv /etc/sysctl.d/99-sysctl.conf /etc/sysctl.d/99-sysctl.conf.pacsave
		fi
		mv /etc/sysctl.conf /etc/sysctl.d/99-sysctl.conf
	fi

	# fix pamac on systems without Gnome session
        detectDE
	pacman -Qq pamac &> /tmp/cmd1
	packages="lxpolkit"
	if [ "$(vercmp $2 20130905-1)" -lt 0 ] && [ "$DE" != "gnome" ] && [ "$(grep 'pamac' /tmp/cmd1)" == "pamac" ]; then
		msg "Fixing polkit issue in pamac ..."
		rm /var/lib/pacman/db.lck &> /dev/null
		pacman --noconfirm -S ${packages} &> /dev/null
	fi

	# depreciate linux39
	pacman -Qq linux39 &> /tmp/cmd1
	packages=$(pacman -Qqs linux39 | sed s'|linux39|linux310|'g)
	if [ "$(vercmp $2 20130829-1)" -lt 0 ] && [ "$(grep 'linux39' /tmp/cmd1)" == "linux39" ]; then
		msg "Depreciating linux39 ..."
		rm /var/lib/pacman/db.lck &> /dev/null
		pacman --noconfirm -Rscn linux39 &> /dev/null
		pacman --noconfirm -S ${packages} &> /dev/null
	fi

	# workaround to install octopi 0.2.0
	pacman -Qq octopi &> /tmp/cmd1
	pacman -Q octopi &> /tmp/cmd2
	packages="octopi octopi-notifier"
	if [ "$(vercmp $2 20130824-1)" -lt 0 ] && [ "$(grep 'octopi' /tmp/cmd1)" == "octopi" ]; then
	   if [ "$(cat /tmp/cmd2 | cut -d- -f1 | cut -d"." -f4)" -lt "0825" ]; then
		msg "Updating octopi ..."
		rm /var/lib/pacman/db.lck &> /dev/null
		check_pkgs
		pacman --noconfirm -S ${packages} &> /dev/null
	   fi
	fi

	# workaround for catalyst-server removal
	pacman -Qq catalyst-server &> /tmp/cmd1
	pacman -Q mhwd-catalyst &> /tmp/cmd2
	packages="catalyst-server catalyst-input catalyst-video"
	conflicts="xf86-input-acecad xf86-input-aiptek xf86-input-evdev xf86-input-joystick xf86-input-keyboard xf86-input-mouse xf86-input-synaptics xf86-input-void xf86-input-wacom xorg-server-common xorg-server"
	if [ "$(vercmp $2 20130820-4)" -lt 0 ] && [ "$(grep 'catalyst-server' /tmp/cmd1)" == "catalyst-server" ]; then
	   if [ "$(cat /tmp/cmd2 | cut -d- -f2 | cut -d" " -f2 | sed -e 's/\.//g')" -lt "138" ]; then
		msg "Preparing Catalyst installation ..."
		rm /var/lib/pacman/db.lck &> /dev/null
		check_pkgs
		pacman --noconfirm -Rdd ${packages} &> /dev/null
		pacman --noconfirm -S ${conflicts} &> /dev/null
	   fi
	fi

	# workaround for bug: http://bugs.manjaro.org/index.php?do=details&task_id=124
	pacman -Qq bluez4 &> /tmp/cmd1
	pacman -Qq bluez &> /tmp/cmd2
	pacman -Q bluez &> /tmp/cmd3
	if [ "$(vercmp $2 20130820-4)" -lt 0 ] && [ "$(grep 'bluez4' /tmp/cmd1)" != "bluez4" ] && [ "$(grep 'bluez' /tmp/cmd2)" == "bluez" ]; then
	   if [ "$(cat /tmp/cmd3 | cut -d. -f1 | cut -d" " -f2)" -lt "5" ]; then
		msg "Fixing bluez ..."
		rm /var/lib/pacman/db.lck &> /dev/null
		pacman --noconfirm -Rdd bluez &> /dev/null
		pacman --noconfirm -S bluez4 bluez-libs &> /dev/null
	   fi
	fi

	# Update filesystem to /usr/bin
	if [ "$(vercmp $2 20130606-1)" -lt 0 ] && [ ! -L "/bin" ] && [ ! -L "/sbin" ] && [ ! -L "/usr/sbin" ]; then
		msg "Binaries move to /usr/bin ..."
		msg "Please be patient."
		local files="$(find /bin/ /sbin/ /usr/sbin/ | tr "\n" " ")"

		# List unowned files
		for file in $files
		do
			local filename="${file##*/}"
			if [ "${filename}" == "" ]; then continue; fi

			pacman -Qo "${file}" &>/dev/null
			if [ $? -ne 0 ]; then msg "Moving unowned file '${file}' to '/usr/bin'"; fi
		done

		# Update database
		local pkgs="$(pacman -Qqo /bin /sbin /usr/sbin | sort -u | tr "\n" " ")"
		for pkg in ${pkgs}
		do
			if [ "${pkg}" == "filesystem" ]; then continue; fi
			local path="/var/lib/pacman/local/$(pacman -Q ${pkg} | sed 's/ /-/g')/files"
			if [ ! -f "${path}" ]; then continue; fi

			sed -i -e 's|^bin/|usr/bin/|' -e 's|^sbin/|usr/bin/|' -e 's|^usr/sbin/|usr/bin/|' -e 's|^bin$|usr/bin|' -e 's|^sbin$|usr/bin|' -e 's|^usr/sbin$|usr/bin|' "${path}"
		done

		# Move files
		for file in $files
		do
			local filename="${file##*/}"
			if [ "${filename}" == "" ]; then continue; fi

			# Check if file is a symlink
			if [ -L "${file}" ]; then
				local filelink="$(readlink "${file}")"

				# Check if destination file exists. Otherwise move the symlink.
				if [ -e "/usr/bin/${filename}" ]; then
					# Remove link
					unlink "${file}"
				elif [[ "${file}" =~ ^"/bin/".*|^"/sbin/".* ]] && [[ "${filelink}" =~ ^"../usr/bin/".* ]]; then
					# Move link to /usr/bin and update relative path
					filelink="$(echo "${filelink}" | sed 's|^\.\./usr/bin/||')"
					ln -s "${filelink}" "/usr/bin/${filename}"
					unlink "${file}"
				elif [[ "${file}" =~ ^"/bin/".*|^"/sbin/".* ]] && [[ "${filelink}" =~ ^"../".* ]]; then
					# Move link to /usr/bin and update relative path
					filelink="$(echo "${filelink}" | sed 's|^\.\./|\.\./\.\./|')"
					ln -s "${filelink}" "/usr/bin/${filename}"
					unlink "${file}"
				elif [[ "${file}" =~ ^"/usr/sbin/".* ]] && [[ "${filelink}" =~ ^"../bin/".* ]]; then
					# Move link to /usr/bin and update relative path
					filelink="$(echo "${filelink}" | sed 's|^\.\./bin/||')"
					ln -s "${filelink}" "/usr/bin/${filename}"
					unlink "${file}"
				else
					# Move link as it is
					ln -s "${filelink}" "/usr/bin/${filename}"
					unlink "${file}"
				fi
			else
				if [ -L "/usr/bin/${filename}" ]; then
					unlink "/usr/bin/${filename}"
					mv "${file}" "/usr/bin/"
				elif [ -e "/usr/bin/${filename}" ]; then
					err "'/usr/bin/${filename}' already exists! Moving file to '/usr/bin_duplicates/${filename}'"
					if [ ! -d "/usr/bin_duplicates" ]; then mkdir "/usr/bin_duplicates"; fi
					mv "${file}" "/usr/bin_duplicates/"
				else
					mv "${file}" "/usr/bin/"
				fi
			fi
		done

		# Fix /usr/bin/init symlink
		ln -sf "../lib/systemd/systemd" "/usr/bin/init"

		# filesystem should own /bin, /sbin and /usr/sbin
		local filesystem_path="/var/lib/pacman/local/$(pacman -Q filesystem | sed 's/ /-/g')/files"
		sed -i 's|^\%FILES\%|\%FILES\%\nbin\nsbin\nusr/sbin|' "${filesystem_path}"

		# Remove directories and create symlinks
		rm -fr /bin
		rm -fr /sbin
		rm -fr /usr/sbin
		ln -s usr/bin /bin
		ln -s usr/bin /sbin
		ln -s bin /usr/sbin

		msg "Now update your system."
	fi

	# Remove obsolete version file of manjaro-system
	if [ -f /var/lib/manjaro-system/version ]; then
		rm /var/lib/manjaro-system/version
	fi
}
