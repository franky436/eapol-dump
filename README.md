# eapol-dump.sh
Small script for dumping and analyzing EAPOLs from a .cap file in order to find a non-broken 4-way handshakes

Use this to extract a clean EAPOL handshake ("consecutive" frame numbers, e.g. 1001, 1003, 1005, 1007!) by using the 4 frame numbers of the handshake:

Specific FRAMES: (wlan.fc.type_subtype == 0x08 exports the beacons so the SSID can be identified)
tshark -r ./bla-01.cap -Y "wlan.fc.type_subtype == 0x08 || frame.number==128160 || frame.number==128162 || frame.number==128164 || frame.number==128168" -w eapol.cap
