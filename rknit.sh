#!/bin/bash

# Function to show help
function show_help
{
    echo "Usage: rknit [-h] [-p] <filename>"
    echo "  -h      knit to html"
    echo "  -p      knit to pdf"
    echo "  or use no flags for html output default"
}

# Varibale to hold document output type
type="html_document"

# Determine flag for output type
while getopts "hp" opt; do
    case ${opt} in
        h )
            type="html_document"
            ;;
        p )
            type="pdf_document"
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
    esac
done

# Shift parameters to point to the filename
shift $((OPTIND -1))

# Read filename
file="$1"

# Ensure we received input
if [ -z "$1" ]; then
    echo "Please provide a file name."
    show_help
    exit 1
fi

# Command to knit file to specifieid output type
Rscript -e "library(rmarkdown); rmarkdown::render('${file}', '${type}')"

