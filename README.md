Modo de Usar:
No script "converter.sh" procure a quarta linha onde diz "arquivo" e coloque seu arquivo de backup de favoritos gerado pelo mozilla (acredito que no chrome também funcione mas ainda nao testei) entre as aspas.
Na linha de baixo coloque entre as aspas o diretório onde quer salvar seus favoritos. 

Dependências:
Nenhuma.

Bugs:
Em favoritos cujo o nome tem barras '/' defini para substituir por '"-"' pois dava erro.
Alguns caracteres específicos não são escritos corretamente no nome dos favoritos.

OBS: O processo é reversível, é possível  para apartir dos diretorios criar novamente o arquivo de backup de favoritos do navegador, mesmo após reorganizar seus favoritos, então pode organizar sem preocupação. Falto implementar esta funcionalidade.
