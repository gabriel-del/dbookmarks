#!/bin/bash

# Preencher:
arquivo="~/bookmarks.html"
diretorio="$USER/Desktop/..."

erro() { echo "Erro: $1!" && exit 1 ;}
linhasarquivo="$(cat $arquivo | wc -l)"
coluna() { echo "$linha" | awk "{print \$$1}" ;}
checkcoluna() { [[ "$(coluna $1 | grep -c $2)" -eq 0 ]] && erro "Nao encontrou $2 na coluna $1, linha $i" ;}
conteudocoluna() { echo "$linha" | awk "{print \$$1}" | cut -d'"' -f2 ;}
titulo() { echo $linha | cut -d'>' -f3 | cut -d'<' -f1 | sed 's/\//"-"/g' ;}
addfav() { touch "$file"
	echo "<HTML>" >> "$file" 
	echo '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">' >> "$file" 
	echo "	<META HTTP-EQUIV = \"REFRESH\" CONTENT = \"0;URL="$link"\">" >> "$file" 
	echo "  $linha" >> "$file" 
	echo "</HTML>" >> "$file" ;}

pwd="$(pwd)" ;cd "$diretorio"

for (( i=10 ; i <= $linhasarquivo ; i++ )) ;do
    linha="$(cat $arquivo | sed -n "$i"p | sed 's/<HR>//g' | tr -s [:space:] | sed 's/^ //g' | sed 's/ $//g')"
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
    
