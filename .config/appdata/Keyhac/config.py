import sys
import os
import datetime

import pyauto
from keyhac import *

def configure(keymap):
    keymap_global = keymap.defineWindowKeymap()

    # Clipboard list
    keymap_global[ "A-S-V" ] = keymap.command_ClipboardList

