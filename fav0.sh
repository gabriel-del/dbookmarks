#!/bin/bash
df="/home/del-user/Desktop/1Del/programas/favoritos"
lsd() { ls -d */ 2> /dev/null | sed 's/\///g' 
}
ultimos="$df"/ultimos

### FUNCAO CRIAR LINK
addfav()
{
    touch "$file"
	echo "<HTML>" > "$file"
	echo "<HEAD>" >> "$file"
	echo "	<TITLE>Aguarde...</TITLE>" >> "$file"
	echo "	<META HTTP-EQUIV = \"REFRESH\" CONTENT = \"0;URL="$link"\">" >> "$file"
	echo "</HEAD>" >> "$file"
	echo "<BODY>" >> "$file"
	echo "	Aguarde..." >> "$file"
	echo "</BODY>" >> "$file"
	echo "</HTML>" >> "$file"
}

erro() { zenity --info --text="Erro: $1!" ; exit 1 ;}

pastas() {
for (( b=0; b < 6 ; b++ )) ; do
cd "$( lsd | sed -n "$(Xdialog --menubox --stdout --title 'Pastas:' 20 0 0 $(lsd | nl)  2>&1)"p)"
[[ -z "$(ls -l | grep ^d)" ]] && break
done
dir="$(pwd)"
}

ultimos() {
    cd "$(cat $ultimos | sed -n "$(Xdialog --menubox --stdout --title 'Ultimos:' 20 0 0 $(cat $ultimos | cut -d/ -f8- | nl)  2>&1)"p)"
    dir="$(pwd)"
}

diretorio() {
case "$(Xdialog --menubox --stdout --title 'Pastas:' 20 0 0 1 Ultimos 2 Pastas  2>&1)" in
    1) ultimos ;;
    2) pastas ;;
    *) erro "opcao invalida" ;;
esac
sed -i "1i\\$(pwd)" $ultimos
sed -i 10q $ultimos
}

nome() {
    c=$(echo "$link" | sed 's/\//\n/g' | wc -l); 
    nome="$( echo "$link"  | sed 's/.com//g' | sed 's/www.//g' | sed 's/.br//g' | sed 's/.htm.*$//g' | sed 's/&[a,o]q//g' | sed 's/chrome.*$//g' | sed 's/search?q//g' | cut -d/ -f3,$c| sed 's/\//./g')"
    d=$(echo "$nome" | sed 's/\./\n/g' | wc -l);
    nome="$( echo "$nome" | cut -d. -f1,$d | sed 's/\./\_/g')"
}

set -x
pwd="$(pwd)"
cd "$df"
link="$(xsel -o)" 
nome
diretorio
file="$dir/$nome.htm"
[[ -e "$file" ]] && erro "Favorito Já Existe"
echo $dir

addfav

cd "$pwd"






