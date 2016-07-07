#Call fiji code within your Python codes by invoking system call of a macro and indication of a folder with input files, e.g. images

import os

fijiPath = "/Users/dani/Desktop/Fiji.app.jan26.app/Contents/MacOS/ImageJ-macosx"
macroPath = "/Users/dani/Dropbox/prog/Python/runExternal/Macro.ijm"
imageFolderPath = "/Users/dani/Dropbox/prog/Python/runExternal/stack/"

os.system(fijiPath +" --headless -macro "+ macroPath +" "+ imageFolderPath)

#if win = ./ImageJ-win64.exe --headless -macro C://whatever//Macro.ijm
#if linux = ./ImageJ-linux64 --headless -macro /whatever/Macro.ijm
