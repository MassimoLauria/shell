#!/usr/bin/env python3

#
# cat ~/.pinboard.cache | fzf --ansi --reverse -m | awk 'BEGIN { FS = "\t" } { print $5 }' | xargs open
#

import sys
import os
import pinboard
import configparser

CFG_FILE = "~/.pinboardrc"


# Piece of code stolen from
# https://stackoverflow.com/questions/7445658/how-to-detect-if-the-console-does-support-ansi-escape-codes-in-python
def supports_color():
    """
    Returns True if the running system's terminal supports color, and False
    otherwise.
    """
    plat = sys.platform
    supported_platform = plat != 'Pocket PC' and (plat != 'win32'
                                                  or 'ANSICON' in os.environ)
    # isatty is not always implemented, #6223.
    is_a_tty = hasattr(sys.stdout, 'isatty') and sys.stdout.isatty()
    return supported_platform and is_a_tty


def get_api_token():

    config_file = os.path.expanduser(CFG_FILE)
    try:
        parser = configparser.RawConfigParser()
        with open(config_file, "r") as f:
            parser.read_file(f)
    except:
        api_token = os.environ.get('PINBOARD_TOKEN') or (
            print("API TOKEN is missing") and exit(1))
    else:
        api_token = parser.get("authentication", "api_token")
    return api_token


def untabify(text):
    return text.replace('\t', '    ')


def main(argv):

    pb = pinboard.Pinboard(get_api_token())
    bookmarks = pb.posts.all()

    force_colors = '--forcecolors' in argv

    if supports_color() or force_colors:
        RESET = "\u001B[0m"
        BLACK = "\u001B[30m"
        RED = "\u001B[31m"
        GREEN = "\u001B[32m"
        YELLOW = "\u001B[33m"
        BLUE = "\u001B[34m"
        PURPLE = "\u001B[35m"
        CYAN = "\u001B[36m"
        WHITE = "\u001B[37m"
    else:
        RESET = ""
        BLACK = ""
        RED = ""
        GREEN = ""
        YELLOW = ""
        BLUE = ""
        PURPLE = ""
        CYAN = ""
        WHITE = ""

    sep = '\t'

    listfmt = CYAN + '{time}' + RESET + sep
    listfmt += YELLOW + '{tags}' + RESET + sep
    listfmt += WHITE + '{title}' + RESET + sep
    listfmt += "---" + sep + BLUE + '{url}' + RESET

    for bm in bookmarks:
        title = untabify(bm.description)
        url = bm.url
        if bm.tags == ['']:
            tags = []
        else:
            tags = bm.tags
        if bm.toread:
            tags.append('toread')
        tags = ",".join(tags)
        time = bm.time.strftime("[%Y-%m-%d]")
        print(listfmt.format(time=time, tags=tags, title=title, url=url))


if __name__ == '__main__':
    main(sys.argv)
