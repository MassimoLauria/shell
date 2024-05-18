#!/bin/sh

export NVM_DIR="$HOME/.nvm"
NVM_PATH="$HOME/.nvm/versions/node/v20.13.1/bin/"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=${NVM_PATH}:${PATH}
