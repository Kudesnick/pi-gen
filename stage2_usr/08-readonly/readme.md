add ` fsck.mode=skip noswap ro` to /boot/cmdline.txt

~~~
apt remove wolfram-engine triggerhappy cron anacron logrotate dphys-swapfile xserver-common lightdm fake-hwclock -y
apt autoremove --purge
~~~

# Migrate to ntp instead of systemd-timesyncd 
https://www.dzombak.com/blog/2024/03/Running-a-Raspberry-Pi-with-a-read-only-root-filesystem.html

~~~
sudo systemctl disable systemd-timesyncd.service
sudo apt install ntp
~~~

edit `/etc/ntp.conf` (`/etc/ntpsec/ntp.conf`): `driftfile /var/tmp/ntp.drift`

~~~
sudo systemctl enable ntp (ntpsec)
~~~

run

~~~
sudo systemctl edit ntp
~~~

(if not work: https://ktg0210.hashnode.dev/editing-etcsystemdsystemservicedoverrideconf-canceled-temporary-file-is-empty)

and add

~~~
[Service]
PrivateTmp=false
~~~

# NetworkManager

add `rc-manager=file` to `/etc/NetworkManager/NetworkManager.conf`

example result:

~~~
[main]
plugins=ifupdown,keyfile
rc-manager=file

[ifupdown]
managed=false
~~~

move files to tmpfs:

~~~
sudo mv /etc/resolv.conf /var/run/resolv.conf && sudo ln -s /var/run/resolv.conf /etc/resolv.conf
sudo rm -rf /var/lib/dhcp && sudo ln -s /var/run /var/lib/dhcp
sudo rm -rf /var/lib/NetworkManager && sudo ln -s /var/run /var/lib/NetworkManager
~~~

# random-seed

~~~
sudo mv /var/lib/systemd/random-seed /tmp/systemd-random-seed && sudo ln -s /tmp/systemd-random-seed /var/lib/systemd/random-seed
~~~

run

~~~
sudo systemctl edit systemd-random-seed.service
~~~

and edit:

~~~
[Service]
ExecStartPre=/bin/echo "" >/tmp/systemd-random-seed
~~~

# disable tasks

sudo systemctl disable systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask man-db.timer
sudo systemctl mask apt-daily.timer
sudo systemctl mask apt-daily-upgrade.timer

# disable journalctl

edit `/etc/systemd/journald.conf`

~~~
[Journal]
Storage=none
~~~

# /etc/fstab

~~~
proc            /proc           proc    defaults          0       0

PARTUUID=76b4450a-01  /boot           vfat    defaults,ro          0       2
PARTUUID=76b4450a-02  /               ext4    defaults,noatime,ro  0       1

tmpfs  /tmp      tmpfs  defaults,noatime,nosuid,nodev   0  0
tmpfs  /var/tmp  tmpfs  defaults,noatime,nosuid,nodev   0  0
tmpfs  /var/log  tmpfs  defaults,noatime,nosuid,nodev,noexec  0  0
tmpfs  /var/spool/mail  tmpfs  defaults,noatime,nosuid,nodev,noexec,size=25m  0  0
tmpfs  /var/spool/rsyslog  tmpfs  defaults,noatime,nosuid,nodev,noexec,size=25m  0  0
tmpfs  /var/lib/logrotate  tmpfs  defaults,noatime,nosuid,nodev,noexec,size=1m,mode=0755  0  0
tmpfs  /var/lib/sudo  tmpfs  defaults,noatime,nosuid,nodev,noexec,size=1m,mode=0700  0  0
~~~

# bash aliases

add to `/etc/bash.bashrc`

~~~
set_bash_prompt(){
    fs_mode=$(mount | sed -n -e "s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p")
    PS1='\[\033[01;32m\]\u@\h${fs_mode:+($fs_mode)}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
}
PROMPT_COMMAND=set_bash_prompt

alias ro='sudo mount -o remount,ro / ; sudo mount -o remount,ro /boot'
alias rw='sudo mount -o remount,rw / ; sudo mount -o remount,rw /boot'
~~~

~~~
sudo echo "sudo mount -o remount,ro / ; sudo mount -o remount,ro /boot" >> /etc/bash.bash_logout
~~~
