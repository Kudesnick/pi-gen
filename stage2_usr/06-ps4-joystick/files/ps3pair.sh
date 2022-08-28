#!/usr/bin/expect -f

spawn bluetoothctl
set timeout 1

expect {
  "Agent registered\r" {
    send "agent on\r"
    expect {
      "Agent is already registered\r" {
        send "default-agent\r"
        expect {
          "Default agent request successful\r" {
            send_user "Please, connect the gamepad to the USB port via USB OTG cable.\r"
            send "scan on\r"
            set timeout 30
            expect {
              "Authorize service * (yes/no): " {
                send "yes\r"
                expect {
                  "*evice ??:??:??:??:??:?? ?rusted: yes\r" {
                    send_user "Please, disconnect the USB OTG cable.\r"
                    expect {
                      "*evice ??:??:??:??:??:?? ?onnected: yes\r"
                      send_user "Success! Make sure that 1 LED on the joystick is on and not blinking.\r"
                      send_user "Input \'quit\' to exit BT agent.\r"
                      send_user "You can test the joystick by typing \'jstest /dev/input/js0\' after quit.\r"
                    } timeout {
                      send_user "Error! The gamepad not connected (timeout)."
                      exit 1
                    }
                  } timeout {
                    send_user "Error! The gamepad not trusted (timeout).\r"
                    exit 1
                  }
                }
              } timeout {
                send_user "Error! The gamepad not found (timeout).\r"
                exit 1
              }
            }
          }
        }
      } timeout {
        send_user "Error! BT agent not started.\r"
        exit 1
      }
    }
  } timeout {
    send_user "Error! BT agent not registered. May be need to install packages bluetooth and libbluetooth3.\r"
    exit 1
  }
}

interact
