#!/bin/bash

inputfile=$1
outputfile="${inputfile%.*}".pdf
pandoc "${inputfile}" -o "${outputfile}" --from markdown --template=eisvogel.tex --filter=pandoc_latex_environment.py --listings --metadata-file=default.yaml


###############

#   This script takes the arguments dragged and dropped over the .desktop file
#   and applies these specific rules to them. Namely, it specifies that the
#   original format is markdown, and that the 'eisvogel' template is used
#   instead of the default pandoc latex template. This setup seems hyperfocused
#   on the specific kind of markdown I tend to use on my PDF documents for my
#   classes/students, but that's fine.

#   The biggest improvement is as follows:


#   ::: def/theorem/idea/whatever
#   Content however I want to do it in markdown
#   More content, it also accepts latex within the markdown
#   even more content.
#   Images work as well!
#   :::