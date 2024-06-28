#!/bin/bash

# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "cwebp could not be found. Please install it using 'brew install webp'."
    exit 1
fi

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [PNG file or directory] [optional: quality (0-100)]"
    exit 1
fi

# Set default quality
QUALITY=80

# Check if quality argument is provided and update it
if [ ! -z "$2" ]; then
    QUALITY=$2
fi

# Function to convert PNG to WebP
convert_png_to_webp() {
    INPUT=$1
    OUTPUT="${INPUT%.*}.webp"
    
    echo "Converting $INPUT to $OUTPUT with quality $QUALITY..."
    cwebp -q $QUALITY "$INPUT" -o "$OUTPUT"
    echo "Conversion complete: $OUTPUT"
}

# Check if the argument is a file or directory
if [ -f "$1" ]; then
    # Single file conversion
    convert_png_to_webp "$1"
elif [ -d "$1" ]; then
    # Directory conversion
    for FILE in "$1"/*.png; then
        if [ -f "$FILE" ]; then
            convert_png_to_webp "$FILE"
        fi
    done
else
    echo "The provided argument is neither a file nor a directory."
    exit 1
fi
