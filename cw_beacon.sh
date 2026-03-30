#!/bin/bash

# ==============================
# Continuous CW Beacon Script
# For rpitx v2 - Pi Zero 2 W
# ==============================

FREQ=28050000         # Frequency in Hz
WPM=18                # Morse speed
PERIOD=20             # Total beacon cycle length (seconds)
MSG="VVV DE KP4MD/B CM98IQ"

trap "echo 'Beacon stopped.'; exit" INT

echo "CW Beacon Started"
echo "Frequency: $FREQ Hz"
echo "Speed: $WPM WPM"
echo "Period: $PERIOD seconds"
echo "Press Ctrl+C to stop."
echo

while true
do
    START=$(date +%s)

    # Transmit message ONCE
    sudo ./morse $FREQ $WPM "$MSG" >/dev/null 2>/dev/null

    # Mandatory 3-second pause
    sleep 3

    END=$(date +%s)
    ELAPSED=$((END - START))

    # Calculate remaining time in beacon cycle
    REMAIN=$((PERIOD - ELAPSED))

    if [ $REMAIN -gt 0 ]; then
        sleep $REMAIN
    fi
done
