# Microdados ENEM 📊

**Aprimoramento do acesso e qualidade de ferramentas de visualização dos microdados do ENEM para alunos e professores**  
Repositório vinculado ao Trabalho de Conclusão de Curso em Ciência da Computação — UFRGS (2025)

---

## 🎯 Propósito

Este projeto tem como objetivo **tornar os microdados do ENEM mais acessíveis e compreensíveis** para alunos e professores.  
A aplicação apresenta **gráficos interativos e tabelas dinâmicas** que permitem explorar o desempenho dos participantes, a dificuldade das questões e comparações entre escolas públicas e privadas, de forma intuitiva e gratuita.

A motivação central é **democratizar o acesso às informações do ENEM**, reduzindo as barreiras técnicas impostas pelo formato bruto dos microdados divulgados pelo INEP.

## 🧩 Estrutura geral

A solução é composta por dois principais módulos:

- **API (C# / .NET Core)**  
  Responsável por processar e servir os dados do ENEM a partir de um arquivo SQLite.  
  A API implementa endpoints REST que permitem a consulta otimizada de dados, garantindo performance mesmo com grandes volumes de informação.

- **Aplicativo Mobile (Flutter)**  
  Interface voltada para dispositivos Android, com visual moderno e responsivo.  
  Apresenta dashboards e gráficos interativos que facilitam a análise dos microdados, baseados nas necessidades identificadas em entrevistas com especialistas da área educacional.

## ⚙️ Tecnologias Utilizadas

**Back-end**

- C# / ASP.NET Core
- SQLite (700MB de dados processados)
- Entity Framework Core (ORM)

**Front-end**

- Flutter (Dart)
- Provider + flutter_hooks para gerenciamento de estado
- Gráficos interativos com pacotes fl_chart

## 📱 Funcionalidades Principais

- Visualização interativa dos resultados do ENEM 2023
- Análise de **número de acertos vs. pontuação** em cada área do conhecimento
- Exibição da **distribuição de dificuldade dos itens** da prova
- Comparativo de desempenho entre **escolas públicas e privadas**
- Textos auxiliares explicativos sobre os conceitos da TRI e interpretação dos gráficos
- Interface otimizada para smartphones, com foco em fluidez e usabilidade

## 🧪 Validação e Resultados

A usabilidade da aplicação foi avaliada por **professores e alunos**, alcançando uma **pontuação SUS média acima de 80**, o que indica excelente aceitação e facilidade de uso.  
Os resultados confirmam que o aplicativo é uma base sólida para futuras expansões, como inclusão de novas edições do ENEM e novas métricas de análise.

## 📚 Referência acadêmica

Este projeto foi desenvolvido como parte do Trabalho de Conclusão de Curso em Ciência da Computação na Universidade Federal do Rio Grande do Sul (UFRGS).

- **Título**: Aprimoramento do acesso e qualidade de ferramentas de visualização dos microdados do ENEM para alunos e professores
- **Autor**: Léo Hernandes de Vasconcelos
- **Orientador**: Prof. Dr. Dennis Giovani Balreira
- **Semestre**: 2025/1

### 📖 [Artigo publicado no LUME - Repositório Digital da UFRGS](https://lume.ufrgs.br/handle/10183/294711)

### 🎥 [Gravação da Apresentação Remota do Projeto](https://youtu.be/UBVwtDJs4xo)
