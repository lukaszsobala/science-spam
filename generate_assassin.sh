#!/bin/bash

# Generates the spamassassin file in one go

sed -e 's/^/blacklist_from\ \*\@\*/g' -e 's/$/\*/g' -e '/\*.*\./s/\*$//' -e '/\.$/s/\./\.\*/' spamdomains.txt > spamdomains-assassin.txt

exit 0
