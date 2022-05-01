#!/bin/bash

#####################################################################################################################################################################
function usage
{
        cat << EOT
Usage:

-p, --produce                            Build the documentation for website
-s, --serve                              Run the built-in dev-server that lets you preview your documentation
-h, --help                               Help about supported command

EOT
}
#####################################################################################################################################################################

# Parse Command Line Arguments

OPTIONS=`getopt -o psh --long produce,serve,help -- "$@"`
if [ $? -ne 0 ]; then
  usage
  exit 1
fi

eval set -- "$OPTIONS"
while true; do
  case "$1" in
    -p|--produce)
        param="produce";
        shift;;
    -s|--serve)
        param="serve";
        shift;;
    --)
        shift; break;;
    -h|--help)
        usage;
        exit 0;;
    *)
      echo "Unexpected argument: $1"
      usage
      exit 1;;
  esac
done

case "$param" in
  serve)
    #echo "In Serve"
    mkdocs serve --livereload -a "0.0.0.0:8000"
    exit 0;;
  produce)
    echo "In produce"
    exit 0;;
  *)
    echo "Unexpected command: $param"
    usage
    exit 1;;
esac