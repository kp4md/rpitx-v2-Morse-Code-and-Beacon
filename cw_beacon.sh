#!/bin/bash

# ==============================
# Continuous CW Beacon Script
# Interactive + FIXED Validation
# ==============================

# Default values
FREQ=28050000
WPM=20
PERIOD=20
MSG="TEST TEST DE Callsign Callsign +"

echo "=============================="
echo " CW Beacon Configuration"
echo "=============================="
echo "Press ENTER to keep default values"
echo

# ----------- INPUT FUNCTION -----------

get_positive_integer() {
    local prompt="$1"
    local default="$2"
    local value

    while true; do
        read -p "$prompt [$default]: " value

        # Use default if empty
        if [[ -z "$value" ]]; then
            echo "$default"
            return
        fi

        # Check numeric
        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
            echo "Error: Input must be a positive integer (numbers only)." >&2
            continue
        fi

        # Check > 0
        if (( value <= 0 )); then
            echo "Error: Value must be greater than zero." >&2
            continue
        fi

        echo "$value"
        return
    done
}

# ----------- PROMPTS -----------

FREQ=$(get_positive_integer "Enter Frequency in Hz" "$FREQ")
WPM=$(get_positive_integer "Enter Speed (WPM)" "$WPM")
PERIOD=$(get_positive_integer "Enter Beacon Period (seconds)" "$PERIOD")

# Message input
read -p "Enter Message [$MSG]: " input
if [[ -n "$input" ]]; then
    MSG="$input"
fi

# ----------- START INFO -----------

echo
echo "=============================="
echo " Beacon Starting"
echo "=============================="
echo "Frequency: $FREQ Hz"
echo "Speed:     $WPM WPM"
echo "Period:    $PERIOD seconds"
echo "Message:   $MSG"
echo "Press Ctrl+C to stop."
echo

# ----------- CLEAN EXIT -----------

trap "echo; echo 'Beacon stopped.'; exit" INT

# ----------- MAIN LOOP -----------

while true
do
    START=$(date +%s)

    echo "Sending:   $MSG"
    sudo ./morse $FREQ $WPM "$MSG" >/dev/null 2>/dev/null

    echo "Pausing:  Press Ctrl+C now to stop."
    sleep 3

    END=$(date +%s)
    ELAPSED=$((END - START))

    REMAIN=$((PERIOD - ELAPSED))

    if (( REMAIN > 0 )); then
        sleep $REMAIN
    fi
done
