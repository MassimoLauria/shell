#!/bin/sh

# Save shell files from deletion


SUFFIX=config-shell

RCFILES="bashrc zshrc inputrc"
ENVFILES="shenv-common shenv-gnupg"
OTHERFILES="install.sh"
ALLFILES="$RCFILES $ENVFILES $OTHERFILES"
BACKUPLIST=$RCFILES

DESTDIR="~"

# Check if it is running in the appropriate directory
# by checking files are present.
CHECK=pass

for FILENAME in $ALLFILES; do
    if [ ! -f $PWD/$FILENAME ]; then 
        CHECK="fail"
    fi
done

if  [ $CHECK = "fail" ]; then
    echo ""
    echo "INSTALLATION ERROR:" 
    echo "Not running in the appropriate directory or some files are missing."
    echo ""
    exit 1
fi


# Check backup possibility.
CHECK="pass"
for FILENAME in $BACKUPLIST; do

    SRC=$DESTDIR/.$FILENAME
    DST=$DESTDIR/.$FILENAME.$SUFFIX
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
    echo "You may want to remove old backup files manually."
    echo ""
    exit 1
fi

# Do backup (by copying and not moving)
for FILENAME in $BACKUPLIST; do

    SRC=$DESTDIR/.$FILENAME
    DST=$DESTDIR/.$FILENAME.$SUFFIX
    
    if [ -f $SRC ]; then 
        cp $SRC $DST
        rm -f $SRC
    fi
    
done

# Do install
for FILENAME in $RCFILES; do
    echo "Installing '$FILENAME' in HOME directory."
    ln -s $PWD/$FILENAME $DESTDIR/.$FILENAME
done
echo "Bye, bye!"

