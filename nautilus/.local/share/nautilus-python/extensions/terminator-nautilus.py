# Terminator Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restrart Nautilus, and enjoy :)
#
# This script was based on a similar one for VS Code written by cra0zy and released to the public domain
# Source: https://github.com/harry-cpp/code-nautilus

#from gi import require_version
#require_version('Gtk', '3.0')
#require_version('Nautilus', '3.0')
from gi.repository import Nautilus, GObject
from subprocess import call
import os
from typing import List
from urllib.parse import unquote

# path to terminator
APPLICATION = 'terminator'

# what name do you want to see in the context menu?
APPLICATION_NAME = 'Terminator'

# always create new window?
NEWWINDOW = False


class TerminatorExtension(GObject.GObject, Nautilus.MenuProvider):

    def launch_application(self, file: Nautilus.FileInfo) -> None:
        filename = unquote(file.get_uri()[7:])

        call(APPLICATION + ' --working-directory ' + filename + '&', shell=True)

    def menu_activate_cb(
        self,
        menu: Nautilus.MenuItem,
        file: Nautilus.FileInfo,
    ) -> None:
        self.launch_application(file)

    def menu_background_activate_cb(
        self,
        menu: Nautilus.MenuItem,
        file: Nautilus.FileInfo,
    ) -> None:
        self.launch_application(file)

    def get_file_items(
            self,
            files: List[Nautilus.FileInfo],
            ) -> List[Nautilus.MenuItem]:

        if len(files) != 1:
            return []

        file = files[0]
        if not file.is_directory() or file.get_uri_scheme() != 'file':
            return []

        item = Nautilus.MenuItem(
            name='NautilusPython::openterminator_file_item',
            label='Open In ' + APPLICATION_NAME,
            tip='Opens directory %s with %s' % (file.get_name(), APPLICATION_NAME)
        )
        item.connect('activate', self.menu_activate_cb, file)

        return [item]

    def get_background_items(
            self,
            current_folder: Nautilus.FileInfo,
            ) -> List[Nautilus.MenuItem]:
        item = Nautilus.MenuItem(
            name='TerminatorOpenBackground',
            label='Open ' + APPLICATION_NAME + ' Here',
            tip='Opens ' + APPLICATION_NAME + ' in the current directory'
        )
        item.connect('activate', self.menu_background_activate_cb, current_folder)

        return [item]
