#!/usr/bin/env bash

for i in $@
do
    echo mkdir "/tmp/${i}-d"
    mkdir "/tmp/${i}-d"
    echo pdftoppm -png -rx 300 -ry 300 "$i" "/tmp/${i}-d/p"
    pdftoppm -png -rx 300 -ry 300 "$i" "/tmp/${i}-d/p"
    for fil in /tmp/${i}-d/p-*
    do
	echo tesseract "$fil" "$fil" pdf
	tesseract "$fil" "$fil" pdf
    done
    echo pdfunite /tmp/${i}-d/p-*.pdf ${i}-searchable.pdf
    pdfunite /tmp/${i}-d/p-*.pdf ${i}-searchable.pdf
done
