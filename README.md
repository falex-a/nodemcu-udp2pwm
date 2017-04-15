## nodemcu-udp2pwm
# Toy Motor Control Server

* **Hardware** - 
  * 3-wheel robot chassis with two motors - e.g. [ebay 10$](http://www.ebay.com/itm/2WD-Motor-Smart-Robot-Car-Chassis-Kit-for-Arduino-Speed-Encoder-Battery-Box-/351999739594)
  * ESP8266-based NodeMCU board - [ebay 3$](http://www.ebay.com/itm/NodeMcu-Lua-WIFI-Internet-Things-development-board-based-ESP8266-CP2102-module-/311727326281?hash=item4894658449:g:A-wAAOSwWnFWA2hU)
    * Lua API: https://nodemcu.readthedocs.io/en/master/
    * Pinout: https://iotbytes.wordpress.com/nodemcu-pinout/
   * Dual H-bridge - e.g. [ebay 1$](http://www.ebay.com/itm/H-bridge-Stepper-Motor-Dual-DC-Motor-Driver-Controller-Board-L9110S-For-Arduino-/161308004962?hash=item258eb4d262:g:c2UAAOSwo4pYgJbp)
    * [arduino example](http://diyprojects.eu/how-to-use-h-bridge-hg7881-with-external-power-supply-and-arduino/)
    * Long story short, two inputs for each motor, one PWM for speed, one GPIO (1/0) for direction
* **Functionality**
  * Connects to wifi, listens to Vx,Vy command via UDP
  * Differential steering - translating Vx,Vy command into individual motor commands:
  * * **Mot1=Vy+Vx, Mot2=Vy-Vx** , so Vx=0 is forward/backward, Vy=0 is turning in place, Vx+Vy=0 is turning with one wheel stationary.
  * Periodic task to update the PWM command to motors.
* Tools
  * ESPlorer to upload the lua files to NodeMCU
