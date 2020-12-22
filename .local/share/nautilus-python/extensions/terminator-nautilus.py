# Terminator Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restrart Nautilus, and enjoy :)
#
# This script was based on a similar one for VS Code written by cra0zy and released to the public domain
# Source: https://github.com/harry-cpp/code-nautilus

from gi import require_version
require_version('Gtk', '3.0')
require_version('Nautilus', '3.0')
from gi.repository import Nautilus, GObject
from subprocess import call
import os

# path to terminator
APPLICATION = 'terminator'

# what name do you want to see in the context menu?
APPLICATION_NAME = 'Terminator'

# always create new window?
NEWWINDOW = False


class TerminatorExtension(GObject.GObject, Nautilus.MenuProvider):

    def launch_application(self, menu, files):
        safepaths = ''
        args = ''

        for file in files:
            filepath = file.get_location().get_path()
            safepaths += '"' + filepath + '" '

            # If one of the files we are trying to open is a folder
            # create a new instance of the application
            if os.path.isdir(filepath) and os.path.exists(filepath):
                args = '--working-directory '

        # if NEWWINDOW:
        #     args = '--new-window '

        call(APPLICATION + ' ' + args + safepaths + '&', shell=True)

    def get_file_items(self, window, files):
        item = Nautilus.MenuItem(
            name='TerminatorOpen',
            label='Open In ' + APPLICATION_NAME,
            tip='Opens the selected directory with ' + APPLICATION_NAME
        )
        item.connect('activate', self.launch_application, files)

        return [item]

    def get_background_items(self, window, file_):
        item = Nautilus.MenuItem(
            name='TerminatorOpenBackground',
            label='Open ' + APPLICATION_NAME + ' Here',
            tip='Opens ' + APPLICATION_NAME + ' in the current directory'
        )
        item.connect('activate', self.launch_application, [file_])

        return [item]
