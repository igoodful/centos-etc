# /etc/profile

# System wide environment and startup programs, for login setup
# Functions and aliases go in /etc/bashrc

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}


if [ -x /usr/bin/id ]; then
    if [ -z "$EUID" ]; then
        # ksh workaround
        EUID=`/usr/bin/id -u`
        UID=`/usr/bin/id -ru`
    fi
    USER="`/usr/bin/id -un`"
    LOGNAME=$USER
    MAIL="/var/spool/mail/$USER"
fi

# Path manipulation
if [ "$EUID" = "0" ]; then
    pathmunge /usr/sbin
    pathmunge /usr/local/sbin
else
    pathmunge /usr/local/sbin after
    pathmunge /usr/sbin after
fi

HOSTNAME=`/usr/bin/hostname 2>/dev/null`
HISTSIZE=1000
if [ "$HISTCONTROL" = "ignorespace" ] ; then
    export HISTCONTROL=ignoreboth
else
    export HISTCONTROL=ignoredups
fi

export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL

# By default, we want umask to get set. This sets it for login shell
# Current threshold for system reserved uid/gids is 200
# You could check uidgid reservation validity in
# /usr/share/doc/setup-*/uidgid file
if [ $UID -gt 199 ] && [ "`/usr/bin/id -gn`" = "`/usr/bin/id -un`" ]; then
    umask 002
else
    umask 022
fi

for i in /etc/profile.d/*.sh /etc/profile.d/sh.local ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then 
            . "$i"
        else
            . "$i" >/dev/null
        fi
    fi
done
unset i
unset -f pathmunge
export PATH=$PATH:/usr/local/bin
ip addr add 192.168.0.201/24 dev wlp3s0 label wlp3s0:1
ip addr add 192.168.0.202/24 dev wlp3s0 label wlp3s0:2
ip addr add 192.168.0.203/24 dev wlp3s0 label wlp3s0:3
ip addr add 192.168.0.204/24 dev wlp3s0 label wlp3s0:4
ip addr add 192.168.0.205/24 dev wlp3s0 label wlp3s0:5
ip addr add 192.168.0.206/24 dev wlp3s0 label wlp3s0:6
ip addr add 192.168.0.207/24 dev wlp3s0 label wlp3s0:7
ip addr add 192.168.0.208/24 dev wlp3s0 label wlp3s0:8
ip addr add 192.168.0.209/24 dev wlp3s0 label wlp3s0:9
ip addr add 192.168.0.210/24 dev wlp3s0 label wlp3s0:10
export PATH=/usr/local/cmake/bin:$PATH
