#!/usr/bin/env bash

shopt -s globstar
shopt -s nullglob

SAXONJAR=${SAXONJAR:-C:/tools/saxon/saxon-he-11.1.jar}

N=4
files=(**/*.xlf)
numfiles=${#files[@]}
echo "Processing $numfiles files"
for file in "${files[@]}"; do
    [ -f "$file" ] || continue
    ((i=i%N)); ((i++==0)) && wait
    ((j++))
    filename=$(basename -- "$file")
    fileProcessedBase="$(dirname -- "$file")/${filename%.*}"
    mkdir -p $(dirname "$fileProcessed")
    java -jar "$SAXONJAR" "-s:$file" "-xsl:tools/XLF12_to_source_text-dita-translatables.xsl" "-o:$fileProcessedBase-source-text-dita-translatables" &
    java -jar "$SAXONJAR" "-s:$file" "-xsl:tools/XLF12_to_source_text-dita.xsl" "-o:$fileProcessedBase-source-text-dita" &
    java -jar "$SAXONJAR" "-s:$file" "-xsl:tools/XLF12_to_source_text-placeholder-translatables.xsl" "-o:$fileProcessedBase-source-text-placeholder-translatables" &

    java -jar "$SAXONJAR" "-s:$file" "-xsl:tools/XLF12_to_target_text-dita-translatables.xsl" "-o:$fileProcessedBase-target-text-dita-translatables" &
    java -jar "$SAXONJAR" "-s:$file" "-xsl:tools/XLF12_to_target_text-dita.xsl" "-o:$fileProcessedBase-target-text-dita" &
    java -jar "$SAXONJAR" "-s:$file" "-xsl:tools/XLF12_to_target_text-placeholder-translatables.xsl" "-o:$fileProcessedBase-target-text-placeholder-translatables" &
    echo "$j/$numfiles"
done

wait
