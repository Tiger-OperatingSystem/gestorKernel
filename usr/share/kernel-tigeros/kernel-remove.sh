#!/bin/bash

windowID="$(xwininfo -name "Configurações de Kernel" | head -n2 | tail -n1 | awk '{print $4}')"

[ "$(pidof yad)" ] && yad --warningyad --modal --borders=32 --fixed --center --undecorated --width=350 --attach="$windowID" --button="Ok":0 \
--text="<b>Já existe outra remoção em andamento!\nAguarde a remoção concluir...</b>" && exit

function removeKernel(){
  cd /tmp
  export DEBIAN_FRONTEND="noninteractive"
  apt-get remove --purge "$1" "$2" -y && {
    update-initramfs -u
    update-grub
    apt-get autoremove --purge -y
    yad --info --modal --borders=32 --fixed --center --undecorated --width=350 --attach="$windowID" --button="Ok":0 \
    --text="<b>O Kernel $3 ($1) foi removido com sucesso! Reinicie o sistema para que as alterações tenham efeito.</b>"
  } || {
    yad --error --modal --borders=32 --fixed --center --undecorated --width=350 --attach="$windowID" --button="Ok":0 \
    --text="<b>Não foi possível concluir a remoção do Kernel $3 ($1)! Por favor, verifique e tente novamente!</b>"
  }
}

if [ ! $(grep unsigned <<< $1) ];then
  header="${1/linux-image/linux-headers}"
fi

removeKernel "$1" "$header" "$2" | \
yad --no-buttons --progress --width=400 --height=100  --borders=32 --fixed --center --undecorated  \
--attach="$windowID" --auto-close --pulsate --progress-text= \
--text="<b>Removendo o Kernel $2 ($1)...\n\nPor favor, aguarde...\n</b>"
