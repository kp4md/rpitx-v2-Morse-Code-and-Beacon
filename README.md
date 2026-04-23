# rpitx-ui & rpitx v2 CW Beacon and Morse Code

**Ihar Yatsevich's [rpitx-ui](https://github.com/IgrikXD/rpitx-ui)** for Raspberry Pi OS 64-bit Trixie and **Evariste Courjaud, F5OEO's [rpitx v2](https://github.com/F5OEO/rpitx)** for Bookworm and earlier Raspberry Pi OS versions turn a Raspberry Pi single board computer into a low power (~10 dBm) radio frequency transmitter with various modulation schemes.  The RF output from the Raspberry Pi pin GPIO4 is a harmonic-rich square wave and requires [a low pass filter](https://photos.app.goo.gl/FRvQL2BddtpLakz9A) and an appropriate license to transmit on the air through an antenna.

The Bash scripts here implement a repeated CW Morse Code beacon with either rpitx-ui or rpitx v2.  
Use the [cw_beacon-ui.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon-ui.sh) script with rpitx-ui or the [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) script with rpitx v2.

Rpitx v2 lacks the ITU Morse Code punctuation and produces code with unusual character and word spacing and rhythm.  Here below is also an improved morse C++ source code for rpitx v2 that remedies those issues.  
Rpitx-ui already includes the punctuation and produces well-spaced Morse Code characters and words.

## Video of Rpitx's 10 mW 7038 kHz test signal heard at KPH WebSDR in Point Reyes, CA (160 km)
[![Rpitx's 10 mW 7038 kHz test signal heard in Point Reyes, CA](https://img.youtube.com/vi/-MB4Yt-R6-c/0.jpg)](https://www.youtube.com/watch?v=-MB4Yt-R6-c)

# Implement a CW Morse code beacon with rpitx-ui on a Raspberry Pi: (Jump to the Section below for rpitx v2)

First, assure that [rpitx-ui](https://github.com/IgrikXD/rpitx-ui) is installed and working on the Raspberry Pi with the 64-bit Trixie OS.

Add the [cw_beacon-ui.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon-ui.sh) shell script into the rpitx-ui folder as follows:
 
To create the executable script, ssh into the RPi 
 
Access the command-line interface by opening a Terminal window or ssh into your Raspberry Pi and Navigate to the rpitx-ui folder.

	~$ cd rpitx-ui
 
Open the Nano text editor to create the file

 	~/rpitx-ui$ nano cw_beacon-ui.sh
 
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

First, assure that [rpitx v2](https://github.com/F5OEO/rpitx) is installed and working on the Raspberry Pi with the Bookworm or earlier OS.

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

Run it from the rpitx directory.

	 ~/rpitx$ ./cw_beacon.sh

# Execute the Morse Code Beacon

Below is a screenshot of a typical run.  
* At each ENTER prompt the user may accept the proposed default or input an alternative.  
The user may use a text editor to change the default values in the script.
* During transmission, the NTP sync is disabled to avoid the random frequency variations that are observed on the Raspberry Pi Zero.
* The screen displays a timestamp and a consecutive serial number during each transmission.
* The user may stop the beacon by pressing Ctrl+C during the pauses between transmissions.
* If the user specifies a maximum count, the beacon will automatically stop after that count.
* After the beacon stops, the NTP sync is enabled and the script exits.

<img width="605" height="514" alt="cw_beacon screenshot" src="https://github.com/user-attachments/assets/391c5ea9-ad39-48e2-bd6b-91317d27f644" />

# (For rpitx v2 only) Add a Simple Morse Beacon to the easytest.sh script menu options.

Follow the same procedure as above, but use the Nano text editor to replace the original easytest.sh script with [this one](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/easytest.sh).  You can edit line 245 of the script to change the 15 WPM speed and the repeating "VVV DE *callsign*" message.  Enter Ctrl-C to stop the repeating beacon.

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

# Contact information:
* Groups.io: [Carol KP4MD at rpitx@Groups.io](https://groups.io/g/rpitx/)
* Email: [kp4md@arrl.net](mailto:kp4md@arrl.net)
