# rpitx-v2-Morse-Code-and-Beacon
[Rpitx v2 by Evariste Courjaud, F5OEO](https://github.com/F5OEO/rpitx), renders Morse Code that is difficult to decode due to unusual element and character spacing and rhythm.  Here are an improved morse C++ source code and executable that correct the timing, adds the International Morse Code punctuation, and a new bash script that implements a repeated Morse Code beacon message.

To implement a Morse code beacon using rpitx v2 on a Raspberry Pi, add [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) shell script in the rpitx folder, substituting your own Frequency, Morse Code speed, Cycle period and Message into the first four declarations.
 
To create the executable script:

ssh into the RPi 

 
Navigate to the rpitx folder

	~$ cd rpitx

 
Create the file

 	~/rpitx$ nano cw_beacon.sh

 
Paste the [cw_beacon.sh](https://github.com/kp4md/rpitx-v2-Morse-Code-and-Beacon/blob/main/cw_beacon.sh) code into Nano

 
Save and exit from Nano 

	 Ctrl+O

Enter

	 Ctrl+X

 
Make it Executable

	 ~/rpitx$ chmod +x cw_beacon.sh

 
Run it

	 ~/rpitx$ ./cw_beacon.sh

