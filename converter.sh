#!/bin/bash

source dados.sh
pwd="$(pwd)"
cd "$diretorio"


prosegue=0
[[ $1 == '-b' ]] && backup=1 || backup =0

erro() { zenity --info --text="Erro: $1!" && exit 1 ;}
addfav() {
    touch "$file" #2> $log
	echo "<HTML>" >> "$file" 
	echo '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">' >> "$file" 
	echo "	<META HTTP-EQUIV = \"REFRESH\" CONTENT = \"0;URL="$link"\">" >> "$file" 
	echo "  $linha" >> "$file" 
	echo "</HTML>" >> "$file" 
}

linhasarquivo="$( cat $arquivo | wc -l)"
coluna() { echo "$linha" | awk "{print \$$1}" ;}
checkcoluna() { [[ "$(coluna $1 | grep -c $2)" -eq 0 ]] && erro "Nao encontrou $2 na coluna $1, linha $i" ;}
conteudocoluna() { echo "$linha" | awk "{print \$$1}" | cut -d'"' -f2 ;}
titulo() { echo $linha | cut -d'>' -f3 | cut -d'<' -f1 | sed 's/\//\\/g' | sed 's/&quot;/"/g' | xmlstarlet unesc ;}


for (( i=10 ; i <= $linhasarquivo ; i++ ))
do
    linha="$(cat $arquivo | sed -n "$i"p | sed 's/<HR>//g' | tr -s [:space:] | sed 's/^ //g' | sed 's/ $//g')"
    [[ "$(titulo)" == 'Outros favoritos' ]] && prosegue=1
    [[ $prosegue -eq 0 ]] && [[ $backup -eq 1 ]] && continue
    case "$(coluna 1)" in
	'<DT><A') checkcoluna 2 HREF; link="$(conteudocoluna 2)"
	    file=$(titulo).html
	    addfav ;;
	'</DL><p>') cd .. ;;
	'<DT><H3') pasta="$(titulo)" ;;
	'<DL><p>') mkdir -p "$pasta";  cd "$pasta" ;;
	'<DD>'*) ;;
	'</DL>') exit 0 ;;
	*) erro "Inicio desconhecido, Linha $i"
    esac
    echo $i
done






cd "$pwd"
    
