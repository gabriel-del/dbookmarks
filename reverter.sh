#!/bin/bash

source dados.sh
pwd="$(pwd)"
cd "$diretorio"


erro() { zenity --info --text="Erro: $1!" ; exit 1 ;}
qtd() { ls -1 | wc -l; }
nivel() { pwd | sed 's/\//\n/g' | wc -l ;}
ea() { echo "$1 a: $(cat .a)" ;}

cabecalho() {
echo '<!DOCTYPE NETSCAPE-Bookmark-file-1>
<!-- This is an automatically generated file.
     It will be read and overwritten.
     DO NOT EDIT! -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Menu de favoritos</H1>

<DL><p>' > "$arquivo"
}

pasta()  {
    [[ -f .a ]] && let i="$(cat .a)"+1 || i=1
    while [ $i -le $(qtd) ] ; do
    atual="$(ls --group-directories-first -1 | sed -n "$i"p)"
    [[ -d "$atual" ]] && tipo=d
    [[ "$atual" =~ \.html$ ]] && tipo=h
    atual2=$(echo $atual | sed 's/\\/\//g' | xmlstarlet esc)

    case $tipo in
	d) echo "$i" > .a
	    cd "$atual"
	    pwd
	    echo "<DT><H3>$atual2</H3>" >> "$arquivo"
	    echo "<DL><p>" >> "$arquivo"
    	    i=0
	    ;;
	h) sed -n 4p "$atual2" >> "$arquivo" 
	    ;;
	*) erro "Arquivo Desconhecido!";;
    esac
let i++
done

[[ -f .a ]] && rm .a
cd .. && echo '</DL><p>' >> "$arquivo"

}




### INICIO
niveli="$(nivel)"
cabecalho
while [ "$(nivel)" -ge "$niveli" ]
do
pasta
done
echo '</DL>' >> "$arquivo"
cd "$pwd"
    # echo -e "Atual: $atual\nI: $i\nTipo: $tipo"

