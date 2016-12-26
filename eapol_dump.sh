#!/bin/bash
echo ""
echo "=================================================="
echo "==== eapol_dump.sh v0.1 - (c) 2016 __franky  ====="
echo "=================================================="
echo ""

if [ $# -lt 1 ] ; then
    echo "Error: Insufficient number of arguments."
    echo ""
    echo "Usage: eapol_dump.sh capfile.cap [mac_address] [frame_number] [frame_number] [frame_number] [frame_number]"
    echo "Example 1: ./eapol_dump.sh caps-01.cap \"01:02:03:04:05:06\""
    echo "Example 2: ./eapol_dump.sh caps-01.cap \"01:02:03:04:05:06\" 1672 1673"

    echo ""
    echo "eapol_dump will dump an overview. in the overview, check that the frame timestamps between eapol frames are close enough to be plausible."
    echo "if a frame number is specified  nonce and mic values for this 802.11 frame will be displayed."
    exit
fi

capfile="$1"
mac_addr="$2"
frameno1="$3"; frameno2="$4"
frameno3="$5"; frameno4="$6"

# first, print an overview including frame timestamps
echo "Frame Tstamp      Src MAC          -> Dest MAC          Type, Info"
echo "----------------------------------------------------------------------"
if [[ -n "$mac_addr" ]]; then
        tshark -r ${capfile} -Y "eapol && wlan.addr==${mac_addr}"
else
        tshark -r ${capfile} -Y "eapol"
fi

frame_details()
{
        frameno="$1"

        # now, print the details:
        if [[ -n "$frameno" ]]; then
                echo ""
                echo "Details for frame #${frameno}" 
                echo "----------------------------------------------------------------------"
                tshark -r "${capfile}" -Y "eapol && wlan.addr==${mac_addr} && frame.number==${frameno}" -V | grep -E "Nonce|WPA Key MIC|Frame.*captured|Key ACK|Ley MIC"
        fi
}

frame_details $frameno1
frame_details $frameno2
frame_details $frameno3
frame_details $frameno4
echo ""
