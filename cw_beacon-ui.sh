#!/bin/bash

# ==============================
# Continuous CW Beacon Script by Carol Milazzo, KP4MD. For use with Ihar Yatsevich's rpitx-ui
# Interactive + Validation + Max Count
# ==============================

# Default values.  Replace Callsign in MSG with your own identifier.
FREQ=28050000
WPM=20
PERIOD=20
MSG="TEST TEST DE Callsign Callsign +"
MAXLOOPS=0   # 0 = infinite

echo "=============================="
echo " CW Beacon Configuration"
echo "=============================="
echo "Press ENTER to keep default values"
echo

# ----------- INPUT FUNCTIONS -----------

get_positive_integer() {
    local prompt="$1"
    local default="$2"
    local value

    while true; do
        read -p "$prompt [$default]: " value

        if [[ -z "$value" ]]; then
            echo "$default"
            return
        fi

        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
            echo "Error: Input must be a positive integer (numbers only)." >&2
            continue
        fi

        if (( value <= 0 )); then
            echo "Error: Value must be greater than zero." >&2
            continue
        fi

        echo "$value"
        return
    done
}

get_non_negative_integer() {
    local prompt="$1"
    local default="$2"
    local value

    while true; do
        read -p "$prompt [$default]: " value

        if [[ -z "$value" ]]; then
            echo "$default"
            return
        fi

        if ! [[ "$value" =~ ^[0-9]+$ ]]; then
            echo "Error: Input must be a non-negative integer (0 or greater)." >&2
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
MAXLOOPS=$(get_non_negative_integer "Enter Maximum Count (0 = infinite)" "$MAXLOOPS")

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
echo "Max Count: $MAXLOOPS"
echo "Message:   $MSG"
echo

# ----------- CLEAN EXIT -----------

trap "echo; echo 'Beacon stopped.'; exit" INT


# ----------- MAIN LOOP -----------

n=0

while true
do
    START=$(date +%s)

    ((n++))

    printf "%s UTC Sending #%d: %s\n" "$(date -u '+%Y-%m-%d %H:%M:%S')" "$n" "$MSG"

    testmorse.sh $FREQ $WPM "$MSG" >/dev/null 2>/dev/null


    echo "Pausing: Press Ctrl+C now to stop."
    sleep 3

    END=$(date +%s)
    ELAPSED=$((END - START))

    REMAIN=$((PERIOD - ELAPSED))

    if (( REMAIN > 0 )); then
        sleep $REMAIN
    fi

    # Exit condition check
    if (( MAXLOOPS > 0 && n >= MAXLOOPS )); then
        echo "Reached maximum count ($MAXLOOPS). Exiting."
        break
    fi
done

echo "Beacon finished."
