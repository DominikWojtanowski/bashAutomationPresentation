#!/bin/bash
USER=$(whoami)

read -p "Z jakiego katalogu chcialbys miec posortowane pliki: " katalog 
filesArr=$(ls /home/$USER/$katalog)
for fileName in ${filesArr[@]}; do
  echo $(stat -c "%w" $fileName)
done
