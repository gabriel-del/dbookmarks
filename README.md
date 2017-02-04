<h2>Configuração</h2>
<p>Abra "favd.sh" procure a quarta linha onde diz "arquivo" e coloque seu arquivo de backup de favoritos gerado pelo mozilla (acredito que no chrome também funcione mas ainda nao testei) entre as aspas.</p>
<p>Na linha de baixo coloque entre as aspas o diretório onde quer salvar seus favoritos.</p> 

<h2>Modo de Uso</h2>
<p>Execute ./fav.sh para transformar o arquivo html em diretórios.</p>

<h2>Modo Reverso</h2>
<p>./favr.sh transforma os diretórios no arquivo html.</p>

<h2>Modo Bakup</h2>
<p>./favb.sh mesmo que o fav.sh porém passa apenas os arquivos na pastra 'Outros favoritos'.</p>

<p>A ideia é salvar os favoritos pelo navegador, a pasta 'Outros favoritos' já é a padrão. Quando sentir necessidade de organizá-los, seguir as etapas</p>

<ol>
<li>Exportar arquivo do navegador.</li>
<li>Executar o favb.sh para trazer os novos favoritos ao seu pc.</li> 
<li>Organizá-los da forma que achar melhor.</li>
<li>Executar o favr.sh para gerar o novo arquivo.</li>
<li>Apagar favoritos do navegador.</li>
<li>Importar favoritos do arquivo para o navegador.</li>
</ol>

<h2>Dependências</h2>
<p>Nenhuma.</p>

<h2>Bugs</h2>
<p>Em favoritos cujo o nome tem barras '/' defini para substituir por '"-"' pois não é possível diretórios ou arquivos com barras.</p>
<p>Alguns caracteres específicos não são escritos corretamente no nome dos favoritos.</p>


