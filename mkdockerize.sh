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
        produce|p)
            #Build the documentation
            mkdocs build -c -d /docs/src/site
            
            #validate if the build directory exists
            if [[ -d "/docs/src/site" ]]
            then
                cp /docs/src/site/index.html /docs/src/
                cd /docs/src; tar -czf /docs/output/mkdocs.tar.gz *
            else
                echo -e "\n Build command failed. \n"
            fi
            
            exit 0
            ;;
        serve|s)
            # validation for tar file and serve the site
            if [[ -f "mkdocs.tar.gz" ]]
            then
                tar -xzf /docs/src/mkdocs.tar.gz -C /docs/src/
                mkdocs serve --livereload -a "0.0.0.0:8000"
            else
                echo -e "\n Please provide valid tar file. \n"
            fi
            exit 0
            ;;
        help|h)
            usage
            exit 0;;
        
        *)
            echo "Unexpected command: $OPT"
            usage
            exit 1;;
        esac
done