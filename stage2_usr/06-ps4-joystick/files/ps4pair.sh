#!/usr/bin/expect -f

send_user "1. run this script\r\n"
send_user "2. Put the DualShock 4 into pairing mode by pressing and holding the 'PlayStation' and 'Share' buttons until the light bar starts flashing.\r\n"

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
send "scan on\r"
expect "Discovery started\r"
expect -re {Device ([0-9A-F:]*) Wireless Controller\r}
set mac $expect_out(1,string)
send "pair $mac\r"
expect {
    "Confirm passkey * (yes/no): " {
        send "yes\r"
        expect "Pairing successful\r"
    }
    "Pairing successful\r" {}
}
send "trust $mac\r"
expect "Changing * trust succeeded\r"
expect "# "
send "quit\r"

send_user "\n"
send_user "PS4 gamepad pairing complete!\r\n"
send_user "Note! Some joysticks after pairing do not connect if you press the button 'PlayStation' (I had a joystick model 'CUH-ZCT2E' vid=0x054c pid=0x05c4). In order for such joysticks to be connected, it is necessary to turn them on by simultaneously pressing the 'PlayStation' and 'Share' buttons.\r\n"
