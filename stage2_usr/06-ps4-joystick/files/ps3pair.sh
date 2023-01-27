#!/usr/bin/expect -f

send_user "1. run this script\r\n"
send_user "2. connect the gamepad to the USB port via USB OTG cable after 'pairable on' command\r\n"
send_user "3. disconnect the USB OTG cable after 'Trusted: yes' message\r\n"
send_user "4. waiting that 1 LED on the joystick is on and not blinking\r\n"

spawn bluetoothctl

set timeout -1

expect "Agent registered\r"
send "agent on\r"
expect "Agent is already registered\r"
send "default-agent\r"
expect "Default agent request successful\r"
send "power on\r"
expect "Changing power on succeeded\r"
send "discoverable on\r"
expect "Changing discoverable on succeeded\r"
set timeout 1
expect "Controller * Discoverable: yes\r"
set timeout -1
send "pairable on\r"
expect "Changing pairable on succeeded\r"
expect "Authorize service * (yes/no): "
send "yes\r"
expect "* Trusted: yes\r"
expect "* Connected: yes\r"
expect "# "
send "quit\r"

send_user "\n"
send_user "PS3 gamepad pairing complete!\r\n"
