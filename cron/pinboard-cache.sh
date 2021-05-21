#!/bin/sh

#
# This simple script complements my shell macro to cache the pinboard
# bookmarks. It is written in such a way that it is easy to run it as
# a cron job.
#

CONFIGDIR=$HOME/config
. $CONFIGDIR/shell/sh.d/pb.sh && pbcache
