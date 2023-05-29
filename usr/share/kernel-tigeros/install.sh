#!/bin/bash

windowID="$(xwininfo -name "Configurações de Kernel" | head -n2 | tail -n1 | awk '{print $4}')"

case $1 in
    youtube-lowlatency)
        x-www-browser "https://www.youtube.com/watch?v=Fqf4WozCUlM"
        exit
        ;;

    xanmod)
        [ ! "$(grep xanmod /etc/apt/sources.list.d/*)" ] && \
        pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY "$PWD"/kernel-repo.sh "xanmod"
        apt-cache search ^linux-image-[0-9] | grep xanmod | cut -d' ' -f1 | sort > /tmp/xanmod.txt
        listxan="$(< /tmp/xanmod.txt)"
        for image in $listxan;do
            if [ "$(dpkg-query -W | grep -i $image)" ];then
                echo "<tr>
                        <td>$image</td>
                        <td>
                            <button type='button' class='btn btn-secondary btn-block disabled'>
                                    Instalado
                            </button>
                        </td>
                    </tr>"
            else
                echo "<tr>
                        <td>$image</td>
                        <td>
                            <button type='button' class='btn btn-primary btn-block'
                                    onclick=\"_run('pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY $PWD/kernel-install.sh $image XanMod')\">
                                    Instalar
                            </button>
                        </td>
                    </tr>"
            fi
        done
        rm /tmp/xanmod.txt
        exit
        ;;

    liquorix)
        [ ! "$(grep liquorix /etc/apt/sources.list.d/*)" ] && \
        pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY "$PWD"/kernel-repo.sh "liquorix"
        apt-cache search ^linux-image-[0-9] | grep liquorix | cut -d' ' -f1 | sort > /tmp/liquorix.txt
        listliq="$(< /tmp/liquorix.txt)"
        for image in $listliq;do
            if [ "$(dpkg-query -W | grep -i $image)" ];then
                echo "<tr>
                        <td>$image</td>
                        <td>
                            <button type='button' class='btn btn-secondary btn-block disabled'>
                                    Instalado
                            </button>
                        </td>
                    </tr>"
            else
                echo "<tr>
                        <td>$image</td>
                        <td>
                            <button type='button' class='btn btn-primary btn-block'
                                    onclick=\"_run('pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY $PWD/kernel-install.sh $image Liquorix')\">
                                    Instalar
                            </button>
                        </td>
                    </tr>"
            fi
        done
        rm /tmp/liquorix.txt
        exit
        ;;

    lowlatency)
        apt-cache search ^linux-image-[0-9] | grep lowlatency | cut -d' ' -f1 | sort > /tmp/lowlatency.txt
        listlow="$(< /tmp/lowlatency.txt)"
        for image in $listlow;do
            if [ "$(dpkg-query -W | grep -i $image)" ];then
                echo "<tr>
                        <td>$image</td>
                        <td>
                            <button type='button' class='btn btn-secondary btn-block disabled'>
                                    Instalado
                            </button>
                        </td>
                    </tr>"
            else
                echo "<tr>
                        <td>$image</td>
                        <td>
                            <button type='button' class='btn btn-primary btn-block'
                                    onclick=\"_run('pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY $PWD/kernel-install.sh $image Low-Latency')\">
                                    Instalar
                            </button>
                        </td>
                    </tr>"
            fi
        done
        rm /tmp/lowlatency.txt
        exit
        ;;

    *) exit ;;
esac
