#!/usr/bin/expect -f

set timeout -1

spawn bluetoothctl

expect "Agent registered\r"
send   "agent on\r"

expect "Agent is already registered\r"
send   "default-agent\r"

expect "Default agent request successful\r"
send   "scan on\r"

expect "Authorize service * (yes/no): "
send   "yes\r"

expect eof
