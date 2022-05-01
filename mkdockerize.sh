#!/bin/bash

#####################################################################################################################################################################
function usage
{
        cat << EOT
Usage:

-p, produce                            Build the documentation for website
-s, serve                              Run the built-in dev-server that lets you preview your documentation
-h, help                               Help about supported command

EOT
}
#####################################################################################################################################################################

# Parse Command Line Arguments

if [ $? -ne 0 ]; then
  usage
  exit 1
fi

while test $# -gt 0; do
        param="$1"
        
        if test "${1::1}" = "-"; then
                if test ${#1} -gt 2 -a "${1::2}" = "--" ; then
                        param="${1:2}"
                else
                        param="${1:1}"
                fi
        else
                param="$1"
        fi
        shift

        case "$param" in
        serve|s)
            tar -xzf /docs/src/mkdocs.tar.gz -C /docs/src/
            mkdocs serve --livereload -a "0.0.0.0:8000"
            exit 0;;
        produce|p)
            mkdocs build -c -d /docs/src/site
            cd /docs/src; tar -czf /docs/output/mkdocs.tar.gz /docs/src/site/index.html *
            exit 0;;
        help|h)
            usage
            exit 0;;
        *)
            echo "Unexpected command: $OPT"
            usage
            exit 1;;
        esac
done