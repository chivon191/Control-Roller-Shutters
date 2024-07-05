# Control Roller Shutters
## Introduce
Control the motor operation via push buttons and software on a computer through Bluetooth connection with PIC18F4550 controller on the door. The system includes warning lights, automatic shutdown upon complete opening/closing of the door, and the ability to pause. Additionally, it can be equipped with sensors to detect obstacles to prevent accidents during door operation.
## Features
- Open/Close/Stop the door by `buttons`
- Control with an `app` on Windows (Bluetooth)
## Hardware
- PIC18F4550
- USB to `UART` Converter
- Module Bluetooth `HC-05`
- Relay
- Button
- Motor
- Warning LED
- `Limit Switch` for Open/Close Operation
## IDE
- MikroC for PIC
- Visual Studio
## Block Diagram
![Block Diagram](https://github.com/chivon191/Control-Roller-Shutters/blob/main/Image/blockdiagram.jpg)
## Schematic
![Schematic](https://github.com/chivon191/Control-Roller-Shutters/blob/main/Image/schematic.jpg)
## Firmware (PIC18F4550)
