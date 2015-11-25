#!/bin/tcsh
# This script will plot a set of forecast and actual TC tracks from an ADECK
setenv GEMDATA /kt11/ktyle/adecks
gpmap << endgpmap
restore ktyle_gpmap_adecks.nts
dev=gf|ktyle_gpmap_adecks.gif|900;800
run

exit
endgpmap
gpend

exit 0
