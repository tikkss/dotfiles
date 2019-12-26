import sys
import os
import datetime

import pyauto
from keyhac import *

def configure(keymap):
    keymap_global = keymap.defineWindowKeymap()

    def ime_off():
        keymap.wnd.setImeStatus(0)

    def ime_on():
        keymap.wnd.setImeStatus(1)

    def vim_escape():
        ime_off()
        keymap.InputKeyCommand( "Esc" )()

    # IME bindings
    keymap_global[ "LAlt" ] = "(235)" # Workaround: Deactivate focused menu when press only alt key
    keymap_global[ "RAlt" ] = "(235)" # Workaround: Deactivate focused menu when press only alt key
    keymap_global[ "O-LAlt" ] = ime_off
    keymap_global[ "O-RAlt" ] = ime_on

    # Vim escape bindings
    keymap_global[ "O-LCtrl" ] = vim_escape

    # Cursor bindings
    keymap_global[ "C-A" ]   = "Home"
    keymap_global[ "C-S-A" ] = "S-Home"
    keymap_global[ "C-B" ]   = "Left"
    keymap_global[ "C-S-B" ] = "S-Left"
    keymap_global[ "C-E" ]   = "End"
    keymap_global[ "C-S-E" ] = "S-End"
    keymap_global[ "C-F" ]   = "Right"
    keymap_global[ "C-S-F" ] = "S-Right"
    keymap_global[ "C-N" ]   = "Down"
    keymap_global[ "C-S-N" ] = "S-Down"
    keymap_global[ "C-P" ]   = "Up"
    keymap_global[ "C-S-P" ] = "S-Up"

    # Alt as Command instead of Cursor bindings
    keymap_global[ "A-A" ]   = "C-A"
    keymap_global[ "A-S-A" ] = "C-S-A"
    keymap_global[ "A-B" ]   = "C-B"
    keymap_global[ "A-S-B" ] = "C-S-B"
    keymap_global[ "A-E" ]   = "C-E"
    keymap_global[ "A-S-E" ] = "C-S-E"
    keymap_global[ "A-F" ]   = "C-F"
    keymap_global[ "A-S-F" ] = "C-S-F"
    keymap_global[ "A-N" ]   = "C-N"
    keymap_global[ "A-S-N" ] = "C-S-N"
    keymap_global[ "A-P" ]   = "C-P"
    keymap_global[ "A-S-P" ] = "C-S-P"

    # Cursor buindings per word
    keymap_global[ "C-W-B" ]   = "C-Left"
    keymap_global[ "C-W-S-B" ] = "C-S-Left"
    keymap_global[ "C-W-F" ]   = "C-Right"
    keymap_global[ "C-W-S-F" ] = "C-S-Right"

    # Ctrl bindings
    keymap_global[ "C-D" ] = "Delete"
    keymap_global[ "C-H" ] = "Back"
    keymap_global[ "C-J" ] = "Enter"
    keymap_global[ "C-K" ] = "S-End","C-X"
    keymap_global[ "C-W" ] = "C-S-Left","Delete"

    # Alt as Command instead of Ctrl bindings
    keymap_global[ "A-D" ] = "C-D"
    keymap_global[ "A-H" ] = "C-H"
    keymap_global[ "A-J" ] = "C-J"
    keymap_global[ "A-K" ] = "C-K"
    keymap_global[ "A-W" ] = "C-W"

    # Alt as Command
    keymap_global[ "A-X" ] = "C-X"   # Cut
    keymap_global[ "A-C" ] = "C-C"   # Copy
    keymap_global[ "A-V" ] = "C-V"   # Paste
    keymap_global[ "A-Z" ] = "C-Z"   # Undo
    keymap_global[ "S-A-Z" ] = "C-Y" # Redo
    keymap_global[ "A-S" ] = "C-S"   # Save
    keymap_global[ "A-T" ] = "C-T"   # New Tab
    keymap_global[ "A-W" ] = "C-W"   # Close Tab
    keymap_global[ "A-Q" ] = "A-F4"  # Quit an app
    keymap_global[ "A-L" ] = "C-L"   # Focus URL bar

    # Application Launcher for Taskbar
    keymap_global[ "C-1" ] = "W-1"
    keymap_global[ "C-2" ] = "W-2"
    keymap_global[ "C-3" ] = "W-3"
    keymap_global[ "C-4" ] = "W-4"
    keymap_global[ "C-5" ] = "W-5"
    keymap_global[ "C-6" ] = "W-6"
    keymap_global[ "C-7" ] = "W-7"
    keymap_global[ "C-8" ] = "W-8"
    keymap_global[ "C-9" ] = "W-9"
    keymap_global[ "C-0" ] = "W-0"

    # Window snap bindings
    keymap_global[ "W-Semicolon" ]   = "W-Left"
    keymap_global[ "W-Quote" ]       = "W-Right"
    keymap_global[ "W-Slash" ]       = "W-Down"
    keymap_global[ "W-OpenBracket" ] = "W-Up"

    # Virtual Desktop bindings
    keymap_global[ "C-Semicolon" ] = "W-C-Left"
    keymap_global[ "C-Quote" ]     = "W-C-Right"

    # HHKB arrow key bindings
    keymap_global[ "RS-Semicolon" ]   = "Left"
    keymap_global[ "RS-Quote" ]       = "Right"
    keymap_global[ "RS-Slash" ]       = "Down"
    keymap_global[ "RS-OpenBracket" ] = "Up"

    # HHKB function key bindings
    keymap_global[ "RS-1" ] = "F1"
    keymap_global[ "RS-2" ] = "F2"
    keymap_global[ "RS-3" ] = "F3"
    keymap_global[ "RS-4" ] = "F4"
    keymap_global[ "RS-5" ] = "F5"
    keymap_global[ "RS-6" ] = "F6"
    keymap_global[ "RS-7" ] = "F7"
    keymap_global[ "RS-8" ] = "F8"
    keymap_global[ "RS-9" ] = "F9"
    keymap_global[ "RS-0" ] = "F0"

    # HHKB windows util key bindings
    keymap_global[ "RS-BackSlash" ] = "Insert"
    keymap_global[ "RS-i" ]         = "PrintScreen"
    keymap_global[ "RS-A-i" ]       = "A-PrintScreen"
    keymap_global[ "RS-l" ]         = "PageUp"
    keymap_global[ "RS-C-l" ]       = "C-PageUp"
    keymap_global[ "RS-Period" ]    = "PageDown"
    keymap_global[ "RS-C-Period" ]  = "C-PageDown"
    keymap_global[ "RS-C-k" ]       = "C-Home"
    keymap_global[ "RS-C-Comma" ]   = "C-End"

    # Clipboard list
    keymap_global[ "A-S-V" ] = keymap.command_ClipboardList

