#!/bin/bash -e

EXTENSION="png"
OUTPUT_DIR="./output-webp"
INPUT_DIR=""

POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -e|--extension)
            EXTENSION="$2"
            shift
            shift
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift
            shift
            ;;
        *)
            POSITIONAL+=("$1")
            shift
            ;;
    esac
done
set -- "${POSITIONAL[@]}"

INPUT_DIR=$1

mkdir -p $OUTPUT_DIR

for filepath in $INPUT_DIR/*.$EXTENSION; do
    filename=$(basename "${filepath%.*}")
    echo "Converting $filepath"
    cwebp -lossless "$filepath" -o "$OUTPUT_DIR/$filename.webp"
done

echo "Finished"
