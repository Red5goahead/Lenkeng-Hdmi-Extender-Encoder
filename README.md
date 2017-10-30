# Lenkeng-Hdmi-Extender-Encoder
Utility for Lenkeng / ESYNiC HDMI extender devices to grab and encode Udp H.264 stream

Autoit project, need last version to compile

Tested with last FFMpeg x86 releases (night builds since 20 Oct 2017) and Amd six-cores Pc desktop (Windows 10 Fall Creators update) and with ESYNiC 120m device (LKV383 chipset)

Releases are compatible with 32-bit Windows operation system too

Thanks to Danman to patch FFMpeg Udp packet zero bug
https://blog.danman.eu/author/danman/

Note: If you choose to save the udp stream by selecting the copy option either as video codec and audio codec, a single FFMpeg process will be used and it will be saved as ts. In all other cases, the process design choice was to use a double FFMpeg process. The first saves the Udp stream to file (raw) and the second reads the write file in real time to manage the encoding process. 
This choice is due to the fact that FFMpeg is not yet able to correctly encode directly from Udp stream. The encoding process starts five seconds after the first one, at the end of the operation it is therefore necessary to wait this time to allow the second process to finish regularly (a message is displayed on the screen to warn).
