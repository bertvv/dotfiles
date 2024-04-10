# VSCode Nautilus Extension
#
# Place me in ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restrart Nautilus, and enjoy :)
#
# This script was written by cra0zy and is released to the public domain
# Source: https://github.com/harry-cpp/code-nautilus

import os
from gi.repository import Nautilus, GObject
from subprocess import call
from typing import List

class VSCodeExtension(GObject.GObject, Nautilus.MenuProvider):

    def launch_vscode(
            self,
            menu: Nautilus.MenuItem,
            files: List[Nautilus.FileInfo]
    ) -> None:
        safepaths = ''
        args = ''

        for file in files:
            filepath = file.get_location().get_path()
            safepaths += '"' + filepath + '" '

            # If one of the files we are trying to open is a folder
            # create a new instance of vscode
            if os.path.isdir(filepath) and os.path.exists(filepath):
                args = '--new-window '

        call('code ' + args + safepaths + '&', shell=True)

    def get_file_items(
            self,
            files: List[Nautilus.FileInfo],
    ) -> List[Nautilus.MenuItem]:

        item = Nautilus.MenuItem(
            name='NautilusPython::open_vscode_files',
            label='Open In VSCode',
            tip='Opens the selected files with VSCode'
        )
        item.connect('activate', self.launch_vscode, files)

        return [item]

    def get_background_items(
            self,
            current_folder: Nautilus.FileInfo,
    ) -> List[Nautilus.MenuItem]:

        item = Nautilus.MenuItem(
            name='NautilusPython::open_vscode_bg',
            label='Open VSCode Here',
            tip='Opens VSCode in the current directory'
        )
        item.connect('activate', self.launch_vscode, [current_folder])

        return [item]
