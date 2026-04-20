# rpitx v2 Morse Code and CW Beacon
[Rpitx v2](https://github.com/F5OEO/rpitx) by Evariste Courjaud, F5OEO, runs a Raspberry Pi single board computer as a low power (~10 dBm) radio frequency transmitter with various modulation schemes.  The Morse Code emissions may be difficult to decode due to unusual element and character spacing and rhythm.  Here are an improved morse C++ source code and executable that correct the timing, adds the International Morse Code punctuation, and bash scripts that implement a repeated CW Morse Code beacon message.

Igor Nikolaevich's [rpitx-ui](https://github.com/IgrikXD/rpitx-ui) already produces well-spaced Morse Code characters and words.  
Use the [cw_beacon-ui.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon-ui.sh) script to implement the CW beacon function in rpitx-ui.

## Video of Rpitx's 10 mW 7038 kHz test signal heard at KPH WebSDR in Point Reyes, CA (160 km)
[![Rpitx's 10 mW 7038 kHz test signal heard in Point Reyes, CA](https://img.youtube.com/vi/-MB4Yt-R6-c/0.jpg)](https://www.youtube.com/watch?v=-MB4Yt-R6-c)

# Implement a CW Morse code beacon with rpitx-ui on a Raspberry Pi: (Jump to the Section below for rpitx v2)

First, assure that [rpitx v2](https://github.com/F5OEO/rpitx) or [rpitx-ui](https://github.com/IgrikXD/rpitx-ui) is installed and working on the Raspberry Pi.

Add the [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) shell script into the rpitx folder as follows:
 
To create the executable script, ssh into the RPi 
 
Access the command-line interface by opening a Terminal window or ssh into your Raspberry Pi and Navigate to the rpitx-ui folder.

	~$ cd rpitx-ui
 
Open the Nano text editor to create the file

	For rpitx-ui 	~/rpitx-ui$ nano cw_beacon-ui.sh
 
Copy and paste this [cw_beacon-ui.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon-ui.sh) code into the Nano edit window.

You may edit lines 9-12 of the script substituting your own default Frequency, Morse Code speed, Cycle period and Message into the first four declarations of the script. 
 
Save and exit from Nano. 

	Ctrl+O → Enter
	Ctrl+X
 
Make cw_beacon-ui.sh Executable.

	 ~/rpitx-ui$ chmod +x cw_beacon-ui.sh
	 
Run it from the rpitx-ui directory.

	 ~/rpitx-ui$ ./cw_beacon-ui.sh

# Implement a CW Morse code beacon with rpitx v2 on a Raspberry Pi: 

First, assure that [rpitx v2](https://github.com/F5OEO/rpitx) or [rpitx-ui](https://github.com/IgrikXD/rpitx-ui) is installed and working on the Raspberry Pi.

Add the [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) shell script into the rpitx folder as follows:
 
To create the executable script, ssh into the RPi 
 
Access the command-line interface by opening a Terminal window or ssh into your Raspberry Pi and Navigate to the rpitx folder.

	~$ cd rpitx

Open the Nano text editor to create the file

 	~/rpitx$ nano cw_beacon.sh

Copy and paste this [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) code into the Nano edit window.
 
You may edit lines 9-12 of the script substituting your own default Frequency, Morse Code speed, Cycle period and Message into the first four declarations of the script. 
 
Save and exit from Nano. 

	Ctrl+O → Enter
	Ctrl+X

Make cw_beacon.sh Executable.

	 ~/rpitx$ chmod +x cw_beacon.sh

Run it from the rpitx-ui directory.

	 ~/rpitx-ui$ ./cw_beacon-ui.sh

# (For rpitx v2) Add a Simple Morse Beacon to the easytest.sh script menu options.

Follow the same procedure as above, but use the Nano text editor to replace the original easytest.sh script with [this one](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/easytest.sh).  You can edit line 244 of the script to change the 15 WPM speed and the repeating "VVV DE *callsign*" message.  Enter Ctrl-C to stop the repeating beacon.

# (For rpitx v2 only) Replace the original "morse" executable to correct the element and character spacing and to add punctuation:

First, assure that [rpitx](https://github.com/F5OEO/rpitx) is installed and working on the Raspberry Pi.

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

Compile the morse.cpp source code

	~/rpitx$ g++ -o morse src/morse/morse.cpp -I./librpitx -L./librpitx -lrpitx
	
Now you can try it. 

FORMAT:

	sudo ./morse frequency(Hz) WPM "MESSAGE"

HF EXAMPLE (sends CQ CQ TEST once on 7.030 MHz at 15 WPM):

	sudo ./morse 7030000 15 "CQ CQ TEST"

VHF EXAMPLE (sends CQ CQ TEST once on 144.1 MHz at 20 WPM):

	sudo ./morse 144100000 20 "CQ CQ TEST"
