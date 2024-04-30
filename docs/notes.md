# Órgãos importantes
- Diretoria de Avaliação da Educação Básica (DAEB)
- Diretoria de Estudos Educacionais (DIRED)

# ENEM
## Sobre a prova
Inicialmente usado como medida de desempenho dos concluintes do Ensino Médio e posteriormente como forma de ingresso em várias faculdades federais.

É possível medir o desempenho na prova através da Teoria Clássica dos Testes (TCT), isto é, somar as alternativas corretas. Um aluno recebe a mesma nota que outro somente pelo fato de acertar a mesma quantidade de questões, independente da área e da dificuldade. O ENEM acredita que é ideal retirar o máximo de informações do gabarito oferecido pelo aluno, inferindo seu desempenho de acordo com a coerência das suas respostas com sua proficiência presumida pelo teste. Esse procedimento de análise é chamado de Teoria de Resposta ao Item (TRI) 
> Há várias teorias ao longo dos anos sobre modelos matemáticos que melhoram a forma de inferir o desempenho dos alunos. O TRI recebeu mais atenção nas últimas décadas devido ao avanço computacional que permitiu a representação dos modelos matemáticos propostos.
>
> - [A Brief History of Item Response Theory](https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=f1be2d875da0a1f43babc097f97000cd342c0a51)
> - [The Basics of Item Response Thoery](https://www.ime.unicamp.br/~cnaber/Baker_Book.pdf)

## Procedimentos para a análise psicométrica
### Pré-teste

É aplicado um conjunto de itens a uma amostra representativa dos alunos que participam do ENEM, fornecendo subsídios para criar uma prova mais precisa. Os dados agregados das aplicações do pré-teste são analisados por meio da TCT e da TRI para cálculos de proficiência de cada área do conhecimento separadamente.

### TCT

Serve para auxiliar a equipe pedagócia sobre possíveis erros ou inconsistências no gabarito da prova e também para analisar a reação dos examinados aos itens das questões.

### TRI

Serve para modelar a probabilidade de um participante com uma determinada proficiência acertar a resposta de um item. A probabilidade é calculada com base em:

- Habilidade do indivíduo: sua proficiência assumida na habilidade testada
- Discriminação do item: a capacidade da questão de diferenciar os participantes que dominam dos que não dominam a habilidade avaliada
- Dificuldade da questão
- Probabilidade de acerto ao acaso 

### Cálculo da nota

Com base no pré-teste, é feita a calibração dos parâmetros de cada item, equalização dos items para permitir sua comparação entre diferentes aplicações, análise de diferenças e ajustes de calibração e por fim o cálculo da proficiência dos alunos por meio de equações diferenciais.

Os parâmetros dos itens são divulgados publicamente apenas 5 anos após a aplicação da prova. Mesmo que fossem divulgados de imediato, não é possível inferir as notas dos anos seguintes devido a todo o processo de cálculo dos parâmetros e da proficiência do aluno que são sensíveis às análises empíricas de cada teste.

# Trabalhos relacionados
## [Professor desenvolve ferramenta para facilitar interpretação dos microdados do Enem](https://extra.globo.com/noticias/educacao/vida-de-calouro/professor-desenvolve-ferramenta-para-facilitar-interpretacao-dos-microdados-do-enem-15445915.html)

Ferramenta para auxuliar professores, coordenadores e diretores a entenderem os dados e direcionarem melhor seus esforços pedagógicos. Além disso, fornecer uma base de conhecimento para quem quiser estender a ferramenta.

O novo ENEM (a partir de 2009) tem o objetivo de ser uma forma de ingresso em faculdades federais e também fornecer dados sobre o desempenho das escolas. Essa última meta não é completamente cumprida, pois dados específicos das áreas de conhecimentos são de difícil acesso - seja por falta de teconologia ou de conhecimento - dentro dos microdados disponibilizados no site do INEP.
 
Sobre o método da TRI, a proficiência do aluno está na mesma escala que a dificuldade do item, portanto é possível compará-las quase que diretamente. O aluno inicia com sua proficiência no valor de 500 e enfrenta um teste no qual as questões já possuem uma dificuldade. Espera-se que o aluno acerte todas as questões de dificuldade abaixo de sua proficiência, ou seja, mesmo que o aluno acerte várias questões difíceis, ele precisa acertar as fáceis primeiro para elevar sua proficiência. Isso não quer dizer é possível perder nota ao acertar uma questão difícil ao acaso, mas ela não valerá tanto dependendo do traço latente do aluno naquele momento. O teste sempre tenta maximizar a proficiência do aluno frente aos acertos e erros que cometeu na prova.

Simplificando, existem dois tipos de comportamentos de corpos escolares perante os resultados do ENEM, os quais o INEP divulga como a média simples dos alunos numa determinada área de conhecimento. Há escolas que usam a nota média unicamente para publicidade, juntamente com uma pressão da sociedade para descobrir as melhores instituições para seus filhos estudarem, o que comprova a existência de uma visão distorcido de como o ENEM funciona e do significado das notas. Entretanto, há escolas que desejam analisar os dados individualmente para entender quais as áreas que estão ficando defasadas no ensino, planejando dessa forma melhorias pontuais nos processos pedagógicos.

O foco do trabalho foram alunos do Rio de Janeiro do Colégio Israelita Brasileiro A. Liessin, que pode ser identificado pelo número do estabelecimento no **Educacenso**. O objetivo pedagógico na análise dos dados era, para cada área do conhecimento: 

- Verificar o desempenho de cada aluno
- Verificar quais questões foram acertadas
- Como reagiram os 
alunos frente às habilidades que foram apresentadas nas provas
- Como foi o 
aproveitamento em redação
- Como os alunos se distribuíram em relação às suas notas

Com isso em mãos, o professor deseja entender quais área devem ser fortalecidas no colégio, comparar diferentes turmas do terceiro ano dentro do Colégio Israelita e seu desempenho perante os dados do estado do Rio de Janeiro para avaliar a efetividade de diferentes estratégias pedagógicas.

Esse escopo do trabalho facilita o tratamento dos dados, uma vez que o arquivo com apenas os dados do Estado do RJ é muito menos custoso para processar se comparado com o arquivo original.