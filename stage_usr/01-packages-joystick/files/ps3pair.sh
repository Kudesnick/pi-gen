#!/usr/bin/expect -f

set timeout 30000

spawn bluetoothctl

expect  "Agent registered\r"
send -- "agent on\r"

expect  "Agent is already registered\r"
send -- "default-agent\r"

expect  "Default agent request successful\r"
send -- "scan on\r"

expect  "[NEW] Device * Sony PLAYSTATION(R)3 Controller Authorize service\r[agent] Authorize service * (yes/no):\r"
send -- "yes\r"

expect  "[Sony PLAYSTATION(R)3 Controller]#\r"
send -- "quit\r"

expect eof
