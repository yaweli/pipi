#!/bin/sh
# mrun
# eli smadar (c)
# 2019
################
export uci=$1
export rut=$2
lower=`echo $uci|tr '[A-Z]' '[a-z]'`

cd /gtm
export gtm_dist="/gtm"
export gtmgbldir="/gtm/$uci.gld"
export gtmroutines="/gtm/$lower/r/ /gtm/mgr/r/ /gtm/"
export gtm_prompt="$uci>"
/gtm/mumps -run $rut
