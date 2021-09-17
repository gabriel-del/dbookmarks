#!/bin/bash
#set -x
arquivo=/opt/gerenciador-favoritos/bookmarks.html
diretorio="/home/$USER/.del-favs"

pwd="$(pwd)"
mkdir -p "$diretorio"
cd "$diretorio"


erro() { zenity --info --text="Erro: $1!" && exit 1 ;}
addfav() {
    touch "$file" || erro "criar arquivo"
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


for (( i=2 ; i <= $linhasarquivo ; i++ ))
do
[[ "$pasta" == "$HOME" ]] && erro "home"
[[ "$(pwd)" == "$HOME" ]] && erro "home"

    linha="$(cat $arquivo | sed -n "$i"p | sed 's/<HR>//g' | tr -s [:space:] | sed 's/^ //g' | sed 's/ $//g')"

    case "$(coluna 1)" in
	'<DT><A') checkcoluna 2 HREF; link="$(conteudocoluna 2)"
	    file=$(titulo).html
	    #echo $file
	    addfav ;;
	'<TITLE>'*) pasta="$(titulo)" ;; 
	'</DL><p>') cd .. ;;
	'<DT><H3') pasta="$(titulo)" ;;
	'<DL><p>') mkdir -p "$pasta";  cd "$pasta" || erro "cd" ; echo $pasta && pwd ;;
	'<DD>'*) ;;
	'</DL>') exit 0 ;;
	#*) let i-=1 && sed -i "$i s/\n//" "$arquivo" || erro "Falhou $i"
	*) erro "Inicio desconhecido, Linha $i"
    esac
    echo $i
done






cd "$pwd"
    
