# homeautomationtimer
Project Title: Home Automation Timer

Components Used:
     N76E003 microcontroller, 3-digit 7-segment LED display, 3 push buttons,
     Relay, Pull-up resistors for the buttons, BC547 transistor, Diode, PCB for 
     circuit implementation.

Functionality and Operation: 
The Home Automation Timer was designed to provide a user-friendly interface for controlling home appliances with a timed operation. The system operates as follows:
o	Display: 
  •	A 3-digit 7-segment LED display 
  •	The display initially shows "000" when the device is powered on or reset 
  •	As users interact with the push buttons, the display updates to show the current count 
  •	The displayed value represents minutes, ranging from 000 to 999

o	User Input Controls: 
  •	Button 1: Increases the displayed number (up counting)
  •	Button 2: Decreases the displayed number (down counting)
  •	Button 3: Activates the timer with the displayed duration

o	 Display Behavior: 
  •	Starting state: "000"
  •	When Button 1 (up count) is pressed, the display increments: 001, 002, 003, etc.
  •	When Button 2 (down count) is pressed, the display decrements: 999, 998, 997, etc. (assuming it wraps around from 000)
  •	The display updates in real-time as the buttons are pressed, providing immediate visual feedback to the user
  •	Once Button 3 is pressed to activate the timer, the display likely shows the countdown of the set time

o	Timer Operation: 
  •	When Button 3 is pressed, the system interprets the displayed number as minutes.
  •	For example, if the display shows "034", pressing Button 3 will set a 34-minute timer.
  •	The relay is activated for the set duration, turning on the connected appliance.
  •	After the set time elapses, the relay turns off, shutting down the appliance.

o	Practical Application: 
  •	This timer can be used to automatically turn off appliances after a set duration.
  •	It's particularly useful for devices that need to run for a specific time, such as water heaters, air conditioners, or cooking appliances.

o	Additional Features:
  •	Reverse  Logic: Optionally, the system can be configured to turn on the appliance after the set delay period, providing flexibility for various home automation scenarios.

Implementation Details:
o	Circuit Implementation and Assembly: 
  •	Used a general-purpose dot-matrix PCB for the project, which provided a flexible platform for the circuit layout
  •	Carefully planned the component placement on the dot matrix PCB to ensure efficient use of space and proper connections
  •	Assembled the components on the PCB by hand, including: 
    –	Soldering the N76E003 microcontroller
    –	Mounting and soldering the 3-digit 7-segment LED display
    –	Attaching the three push buttons
    –	Soldering the relay, BC547 transistor, diode, and pull-up resistors
    –	Adding any necessary jumper wires to complete circuit connections
  •	Paid special attention to proper soldering techniques to ensure reliable electrical connections
  •	Verified all connections after soldering to prevent short circuits and ensure correct wiring
  
o	Programming: 
  •	Wrote the entire code in assembly language without relying on external resources, demonstrating my grasp of the concepts learned during the internship.
  •	Implemented efficient multiplexing for the 3-digit 7-segment LED display.

o	Interrupt Handling: 
  •	Utilized pin interrupts for the push buttons to ensure responsive user input.
  •	Each button press triggered an interrupt, allowing immediate response to user actions.

o	Relay Control: 
  •	Used the BC547 transistor to interface the microcontroller with the relay, ensuring proper current handling.
  •	Implemented safety features to prevent relay chattering and ensure clean switching.

Challenges and Solutions:
o	Debouncing the push buttons in software to prevent false triggers.
o	Optimizing the assembly code for efficient execution and minimal power consumption.
o	Ensuring accurate timing over long durations by properly configuring and managing the microcontroller's timers.

Skills Utilization:
This project allowed me to apply a wide range of skills acquired during the internship, including:
o	Assembly language programming
o	Interrupt handling
o	Timer configuration and management
o	I/O interfacing (buttons and LED display)
o	Circuit design and assembly
