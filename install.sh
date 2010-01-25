#!/bin/sh

# Save shell files from deletion


SUFFIX=config-shell
BACKUPLIST=".bashrc .zshrc"
CHECK=pass

# Check if it is running in the appropriate directory
if [ ! -f $PWD/bashrc ]; then 
        CHECK="fail"
    fi
if [ ! -f $PWD/zshrc ]; then 
        CHECK="fail"
    fi
if [ ! -f $PWD/install.sh ]; then 
        CHECK="fail"
    fi

if  [ $CHECK = "fail" ]; then
    echo ""
    echo "INSTALLATION ERROR:" 
    echo "Not running in the appropriate directory."
    echo ""
    exit 1
fi

# Check backup possibility.
CHECK="pass"
for FILENAME in $BACKUPLIST; do

    SRC=~/$FILENAME
    DST=~/$FILENAME.$SUFFIX
    CHECKITEM="pass"

    if [ -f $SRC ] && [ -f $DST ]; then 
        CHECKITEM="fail"
    fi

    echo "BACKUP: $SRC ---> $DST ($CHECKITEM)"
    
    if [ $CHECKITEM = "fail" ]; then 
        CHECK="fail" 
    fi
done

if  [ $CHECK = "fail" ]; then
    echo ""
    echo "INSTALLATION ERROR:" 
    echo "Can't make backup files where necessary."
    echo ""
    exit 1
fi

# Do backup (by copying and not moving)
for FILENAME in $BACKUPLIST; do

    SRC="~/$FILENAME"
    DST="~/$FILENAME.$SUFFIX"

    mv $SRC $DST
done

# Do install
echo "Installing 'bashrc' in HOME directory."
ln -s $PWD/bashrc ~/.bashrc
echo "Installing  'zshrc' in HOME directory."
ln -s $PWD/zshrc ~/.zshrc
echo "Bye, bye!"

