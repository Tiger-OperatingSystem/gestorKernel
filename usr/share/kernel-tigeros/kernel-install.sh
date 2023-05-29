#!/bin/bash

windowID="$(xwininfo -name "Configurações de Kernel" | head -n2 | tail -n1 | awk '{print $4}')"

[ "$(pidof yad)" ] && yad --warning --info --modal --borders=32 --fixed --center --undecorated --width=350 --attach="$windowID" --button="Ok":0 \
--text="<b>Já existe outra instalação em andamento!\nAguarde a instalação concluir...</b>" && exit

function installKernel(){
  export DEBIAN_FRONTEND="noninteractive"
  apt-get install "$1" "$2" -y && {
    update-initramfs -u
    update-grub
    yad --info --width=350 --modal --borders=32 --fixed --center --undecorated --width=350 --attach="$windowID" --button="Ok":0 \
    --text="<b>O Kernel $3 ($1) foi instalado com sucesso! Reinicie o sistema para que as alterações tenham efeito.</b>"
  } || {
    yad --error --width=350 --modal --borders=32 --fixed --center --undecorated --width=350 --attach="$windowID" --button="Ok":0 \
    --text="<b>Não foi possível concluir a instalação do Kernel $3 ($1)! Por favor, verifique e tente novamente!</b>"
  }
}

header="${1/linux-image/linux-headers}"

if [[ $2 == *"Liquorix" ]]; then
  installKernel "$1"  | \
  yad --no-buttons --progress --width=400 --height=100  --borders=32 --fixed --center --undecorated  \
  --attach="$windowID" --auto-close --pulsate --progress-text= \
  --text="<b>Instalando o Kernel $2, isso leva alguns minutos dependendo da sua conexão com a internet...\n\nPor favor, aguarde...\n</b>"
else
  installKernel "$1" "$header" "$2" | \
  yad --no-buttons --progress --width=400 --height=100  --borders=32 --fixed --center --undecorated  \
  --attach="$windowID" --auto-close --pulsate --progress-text= \
  --text="<b>Instalando o Kernel $2, isso leva alguns minutos dependendo da sua conexão com a internet...\n\nPor favor, aguarde...\n</b>"
fi
