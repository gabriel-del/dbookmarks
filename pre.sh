#!/bin/bash
arquivo=bookmarks.html
cat pre-bookmarks.html | tr -d "\n" | sed 's/\t//g' > "$arquivo"
sed -i -e 's/<TITLE>/\n<TITLE>/g' "$arquivo"
sed -i -e 's/<DT><A/\n<DT><A/g' "$arquivo"
sed -i -e 's/<DT><H3/\n<DT><H3/g' "$arquivo"
sed -i -e 's/<DL><p>/\n<DL><p>/g' "$arquivo"
sed -i -e 's/<DD>/\n<DD>/g' "$arquivo"
sed -i -e 's/<\/DL>/\n<\/DL>/g' "$arquivo"


