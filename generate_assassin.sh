#!/bin/bash

# ---------------------------------------------------------------
# SpamAssassin Domain List Generator
# 
# This script converts a plain list of spam domains in spamdomains.txt
# into a SpamAssassin-compatible blacklist format.
# Output is saved to spamdomains-assassin.cf
# ---------------------------------------------------------------

INPUT_FILE="spamdomains.txt"
OUTPUT_FILE="spamdomains-assassin.cf"

# First, sort the input file alphabetically and remove empty lines in-place
export LC_ALL=C # Set locale to C for consistent soritng of special characters
sort -o "${INPUT_FILE}" "${INPUT_FILE}" 
sed -i '/^[[:space:]]*$/d' "${INPUT_FILE}"

# Process the domains with the following transformations:
#  1. Add "blacklist_from *@*" prefix to each domain
#  2. Add "*" suffix to each line
#  3. Remove trailing "*" if line already contains "*" and a dot
#  4. Replace trailing dot with ".*"

sed -e 's/^/blacklist_from\ \*\@\*/g' \
    -e 's/$/\*/g' \
    -e '/\*.*\./s/\*$//' \
    -e '/\.$/s/\./\.\*/' \
    "${INPUT_FILE}" > "${OUTPUT_FILE}"

echo "SpamAssassin blacklist generated: ${OUTPUT_FILE}"

exit 0
