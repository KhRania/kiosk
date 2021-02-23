#!/bin/bash
#########################################################
#                                                       #
# should have exec right                                #
# $ chmod 777 keyboard_disable.sh                       #
#                                                       #
#########################################################
xmodmap -e "keycode 23 = "  # Disable TAB
xmodmap -e "keycode 37 = "  # Disable Left CTRL
xmodmap -e "keycode 50 = "  # Disable Left SHIFT
xmodmap -e "keycode 62 = "  # Disable Right SHIFT
xmodmap -e "keycode 64 = "  # Disable Left Alt
xmodmap -e "keycode 67 = "  # Disable F1
xmodmap -e "keycode 68 = "  # Disable F2
xmodmap -e "keycode 69 = "  # Disable F3
xmodmap -e "keycode 70 = "  # Disable F4
xmodmap -e "keycode 71 = "  # Disable F5
xmodmap -e "keycode 72 = "  # Disable F6
xmodmap -e "keycode 73 = "  # Disable F7
xmodmap -e "keycode 74 = "  # Disable F8
xmodmap -e "keycode 75 = "  # Disable F9
xmodmap -e "keycode 76 = "  # Disable F10
xmodmap -e "keycode 95 = "  # Disable F11
xmodmap -e "keycode 96 = "  # Disable F12
xmodmap -e "keycode 105 = " # Disable Right Alt
xmodmap -e "keycode 119 = " # Disable Delete
xmodmap -e "keycode 108 = " # Disable Right Alt
xmodmap -e "keycode 204 = " # Disable Left Alt
xmodmap -e "keycode 133 = " # Disable Left "Super" Key
xmodmap -e "keycode 205 = " # Disable
xmodmap -e "keycode 206 = " # Disable
xmodmap -e "keycode 207 = " # Disable
xmodmap -e "keycode 231 = " # Disable Cancel