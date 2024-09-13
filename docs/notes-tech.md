# Tecnologias utilizadas

## Front
App Mobile em React Native

O mais burro possível, só renderiza coisas da API, pois se for necessário fazer mudanças de lógica, é mais difícil esperar a loja aceitar uma nova versão

## Back
API em ASP NET Core, comunicando com arquivo SQLite em disco através do Entity Framework

Os mapeamentos de algumas informações, como `Código de Habilidade` &rarr; `Descrição da Habilidade` é preferível ser feito em código em vez de no banco de dados, pois:
- É mais legível
- Idealmente o banco não deveria ser a fonte dessas conexões. Elas são encontradas em arquivos não .csv no site do INEP. 


