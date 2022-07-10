#  File: update_stratix.do
#    Copyright (C) ALDEC Inc.
#  File can be used to update library stratix for Altera
#  To update the library, perform the following steps:
#    1. Update existing library source files
#    2. Execute this macro file

set OPT -O3
#uncomment following line to compile with debug information
#set OPT -dbg

setlibrarymode -rw stratix
clearlibrary
acom -work stratix $OPT $DSN\src\stratix_atoms.vhd
acom -work stratix $OPT $DSN\src\stratix_components.vhd
setlibrarymode -ro stratix
