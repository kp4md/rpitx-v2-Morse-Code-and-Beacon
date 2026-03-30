# rpitx-v2-Morse-Code-and-Beacon
[Rpitx v2 by Evariste Courjaud, F5OEO](https://github.com/F5OEO/rpitx), renders Morse Code that may be difficult to decode due to unusual element and character spacing and rhythm.  Here are an improved morse C++ source code and executable that correct the timing, adds the International Morse Code punctuation, and a new bash script that implements a repeated Morse Code beacon message.

# Implement a Morse code beacon using rpitx v2 on a Raspberry Pi:

First, assure that [rpitx](https://github.com/F5OEO/rpitx) is installed on the Raspberry Pi.

Add the [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) shell script into the rpitx folder as follows:
 
To create the executable script, ssh into the RPi 

 
Access the command-line interface by opening a Terminal window or ssh into your Raspberry Pi and Navigate to the rpitx folder.

	~$ cd rpitx

 
Open the Nano text editor to create the file

 	~/rpitx$ nano cw_beacon.sh

 
Copy and paste this [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) code into the Nano edit window.

Edit lines 8-11 of the script substituting your own Frequency, Morse Code speed, Cycle period and Message into the first four declarations of the script. 
 
Save and exit from Nano. 

	Ctrl+O → Enter
	Ctrl+X
 
Make cw_beacon.sh Executable.

	 ~/rpitx$ chmod +x cw_beacon.sh

 
Run it

	 ~/rpitx$ ./cw_beacon.sh

# Add a Simple Morse Beacon to the easytest.sh script menu options.

Follow the same procedure as above, but use the Nano text editor to replace the original easytest.sh script with [this one](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/easytest.sh).  You can edit the script to change the 15 WPM speed and the repeating "VVV DE *callsign*" message.  Enter Ctrl-C to stop the repeating beacon.

# Replace the original "morse" executable to correct the element and character spacing and to add punctuation:

First, assure that [rpitx](https://github.com/F5OEO/rpitx) is installed on the Raspberry Pi.

Access the command-line interface by opening a Terminal window or ssh into your Raspberry Pi and Navigate to the /rpitx/src/morse folder.

	~$ cd rpitx/src/morse

Backup the original morse.cpp source code file.

	~/rpitx/src/morse$ cp morse.cpp morse.cpp.original

Now you can always restore it if necessary with: cp morse.cpp.original morse.cpp

Use the Nano text editor to replace the old morse source code file.

Open the morse.cpp file:

	~/rpitx/src/morse$ nano morse.cpp

Delete everything inside (Ctrl+K repeatedly).

Copy and Paste the full updated [morse.cpp](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/src/morse.cpp) source code into the Nano edit window.

Save:

	Ctrl+O → Enter
	Ctrl+X

Return to the rpitx directory and clean any old build.

	~/rpitx/src/morse$ cd ~/rpitx
	~/rpitx$ rm -f *.o morse

Compile the morse.cpp course code

	~/rpitx$ g++ -o morse src/morse/morse.cpp -I./librpitx -L./librpitx -lrpitx
	
Now you can try it. 

FORMAT:

	sudo ./morse frequency(Hz) WPM "MESSAGE"

HF EXAMPLE (sends CQ CQ TEST once on 7.030 MHz at 15 WPM):

	sudo ./morse 7030000 15 "CQ CQ TEST"

VHF EXAMPLE (sends CQ CQ TEST once on 7.030 MHz at 15 WPM):

	sudo ./morse 144100000 20 "CQ CQ TEST"
