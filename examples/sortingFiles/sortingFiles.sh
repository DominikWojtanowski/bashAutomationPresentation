#!/bin/bash
IFS="-" #ustawiamy internal field separator aby pozniejsza skaldnia tablicy
# odzielala wartosci w miejscu "-" a nie " "
USER=$(whoami)
source /home/$user/Projects/bashAutomationPresentation/examples/sortingFiles/bashSlownik.sh

read -p "Z jakiego katalogu chcialbys miec posortowane pliki: " katalog
read -p "Podaj lokalizacje gdzie pliki powinny byc odzielone(defaultowe to /home/$USER/Sorted): " posortowanyKatalog

if [[ "$posortowanyKatalog" == "" ]]; then
    posortowanyKatalog="/home/$USER/Sorted"
fi

for fileName in /home/$USER/$katalog/*; do
    echo $fileName
    if [ -f $fileName ]; then
        output=($(date -d "$(stat -c "%w" "$fileName")" +"%Y-%m-%d"))
        returnCode=$?
        if [ $returnCode -eq 0 ]; then
            echo "${slownikMiesiac[${output[1]}]}"
            katalogDoUtworzenia="$posortowanyKatalog/${output[0]}/${slownikMiesiac[${output[1]}]}/${output[2]}"
            mkdir -p "$katalogDoUtworzenia"
            mv "$fileName" "$katalogDoUtworzenia"
            echo "przeniesiono $fileName do $katalogDoUtworzenia"
        fi
    fi
done
