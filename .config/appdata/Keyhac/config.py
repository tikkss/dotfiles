import sys
import os
import datetime

import pyauto
from keyhac import *

def configure(keymap):
    # Functions
    if 1:
        def activate_if(process_names):
            def _activate_if(window):
                if window.getProcessName() in process_names:
                    return True
                return False
            return _activate_if

        def activate_unless(process_names):
            def _activate_unless(window):
                if window.getProcessName() not in process_names:
                    return True
                return False
            return _activate_unless

        def ime_off():
            keymap.wnd.setImeStatus(0)

        def ime_on():
            keymap.wnd.setImeStatus(1)

        def vim_escape():
            ime_off()
            keymap.InputKeyCommand( "Esc" )()

    # Global bindings
    if 1:
        keymap_global = keymap.defineWindowKeymap()

        keymap_global[ "W-Z" ] = keymap.command_ReloadConfig

        # Escape bindings
        keymap_global[ "O-LCtrl" ] = "Esc"

        # IME bindings
        keymap_global[ "LAlt" ] = "(235)" # Workaround: Deactivate focused menu when press only alt key
        keymap_global[ "RAlt" ] = "(235)" # Workaround: Deactivate focused menu when press only alt key
        keymap_global[ "O-LAlt" ] = ime_off
        keymap_global[ "O-RAlt" ] = ime_on

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

    # Vim escape bindings
    if 1:
        keymap_post_vim_esc_if_left_control_is_pressed_alone = keymap.defineWindowKeymap(
            check_func=activate_if([
              "cmd.exe",
              "gvim.exe",
              "mintty.exe",
              "powershell.exe",
              "rubymine64.exe",
            ])
        )
        keymap_post_vim_esc_if_left_control_is_pressed_alone[ "O-LCtrl" ] = vim_escape

    # Mac like bindings
    if 1:
        keymap_mac_like = keymap.defineWindowKeymap(
            check_func=activate_unless([
              "cmd.exe",
              "gvim.exe",
              "mintty.exe",
              "powershell.exe",
              "rubymine64.exe",
            ])
        )

        # Cursor bindings
        keymap_mac_like[ "C-A" ]   = "Home"
        keymap_mac_like[ "C-S-A" ] = "S-Home"
        keymap_mac_like[ "C-B" ]   = "Left"
        keymap_mac_like[ "C-S-B" ] = "S-Left"
        keymap_mac_like[ "C-E" ]   = "End"
        keymap_mac_like[ "C-S-E" ] = "S-End"
        keymap_mac_like[ "C-F" ]   = "Right"
        keymap_mac_like[ "C-S-F" ] = "S-Right"
        keymap_mac_like[ "C-N" ]   = "Down"
        keymap_mac_like[ "C-S-N" ] = "S-Down"
        keymap_mac_like[ "C-P" ]   = "Up"
        keymap_mac_like[ "C-S-P" ] = "S-Up"

        # Alt as Command instead of Cursor bindings
        keymap_mac_like[ "A-A" ]   = "C-A"
        keymap_mac_like[ "A-S-A" ] = "C-S-A"
        keymap_mac_like[ "A-B" ]   = "C-B"
        keymap_mac_like[ "A-S-B" ] = "C-S-B"
        keymap_mac_like[ "A-E" ]   = "C-E"
        keymap_mac_like[ "A-S-E" ] = "C-S-E"
        keymap_mac_like[ "A-F" ]   = "C-F"
        keymap_mac_like[ "A-S-F" ] = "C-S-F"
        keymap_mac_like[ "A-N" ]   = "C-N"
        keymap_mac_like[ "A-S-N" ] = "C-S-N"
        keymap_mac_like[ "A-P" ]   = "C-P"
        keymap_mac_like[ "A-S-P" ] = "C-S-P"

        # Cursor buindings per word
        keymap_mac_like[ "C-W-B" ]   = "C-Left"
        keymap_mac_like[ "C-W-S-B" ] = "C-S-Left"
        keymap_mac_like[ "C-W-F" ]   = "C-Right"
        keymap_mac_like[ "C-W-S-F" ] = "C-S-Right"

        # Ctrl bindings
        keymap_mac_like[ "C-D" ] = "Delete"
        keymap_mac_like[ "C-H" ] = "Back"
        keymap_mac_like[ "C-J" ] = "Enter"
        keymap_mac_like[ "C-K" ] = "S-End","Delete"
        keymap_mac_like[ "C-U" ] = "S-Home","Delete"
        keymap_mac_like[ "C-W" ] = "C-S-Left","Delete"

        # Alt as Command instead of Ctrl bindings
        keymap_mac_like[ "A-D" ] = "C-D"
        keymap_mac_like[ "A-H" ] = "C-H"
        keymap_mac_like[ "A-J" ] = "C-J"
        keymap_mac_like[ "A-K" ] = "C-K"
        keymap_mac_like[ "A-U" ] = "C-U"
        keymap_mac_like[ "A-W" ] = "C-W"

