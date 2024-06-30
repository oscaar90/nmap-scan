#!/bin/bash

# Verificar si se ha proporcionado un objetivo
if [ -z "$1" ]; then
    echo "Uso: $0 <dirección IP>"
    exit 1
fi

# Configurar variables
TARGET="$1"
RATE="2000"

# Escaneo de puertos abiertos
echo "Escaneando todos los puertos en $TARGET..."
ports=$(nmap -p- -sS -n -Pn --min-rate=$RATE $TARGET | grep '^[0-9]' | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')

# Verificar si se encontraron puertos abiertos
if [ -z "$ports" ]; then
    echo "No se encontraron puertos abiertos."
    exit 1
fi

# Escaneo detallado en los puertos abiertos
echo "Escaneando puertos específicos: $ports en $TARGET..."
nmap -p$ports -sCV -oN detailed_scan_$TARGET.txt $TARGET

# Informar que el escaneo detallado ha terminado
echo "Escaneo detallado completo. Resultados guardados en detailed_scan_$TARGET.txt"

# Escaneo de vulnerabilidades en los puertos abiertos
echo "Escaneando vulnerabilidades en puertos específicos: $ports en $TARGET..."
nmap -p$ports --script vuln -oN vuln_scan_$TARGET.txt $TARGET

# Informar que el escaneo de vulnerabilidades ha terminado
echo "Escaneo de vulnerabilidades completo. Resultados guardados en vuln_scan_$TARGET.txt"