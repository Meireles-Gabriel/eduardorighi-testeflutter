
## Sobre minha participação no teste

Participei deste teste técnico com o objetivo de demonstrar minhas habilidades em desenvolvimento Flutter. Com base na estrutura fornecida e seguindo as especificações do design no Figma, implementei todas as funcionalidades solicitadas de forma limpa e organizada.

**Como executei a tarefa:**
- **Refatoração e componentização**: Separei o código da página POS em componentes específicos (`PosHeader`, `CategoriesSection`, `ProductsSection`, `CategoryCard`, `ProductCard`) e criei utilitários reutilizáveis (`PosUtils`)
- **Interface responsiva**: Implementei layouts adaptativos para mobile, tablet e desktop com breakpoints apropriados e componentes específicos para cada contexto
- **Funcionalidade de busca**: Desenvolvi sistema de busca inteligente que filtra categorias por nome ou por itens contidos nelas
- **Estados visuais**: Adicionei efeitos de hover, animações e feedbacks visuais para melhorar a experiência do usuário
- **Gerenciamento de estado**: Utilizei MobX para controle reativo do estado da aplicação com computed properties e actions organizadas

O resultado final mantém toda a funcionalidade original com código limpo, seguindo boas práticas do Flutter/Dart.

Agradeço pela oportunidade de participar deste processo seletivo e aguardo ansiosamente pelos próximos passos. Estou à disposição para esclarecimentos adicionais sobre a implementação.

---

# Teste Técnico - Seleção de Categorias e Itens (Flutter para Windows)

Este teste tem como objetivo avaliar desenvolvedores Flutter na criação de uma página de seleção de categorias e itens, utilizando as bibliotecas já presentes no projeto.

## Descrição da Tarefa

O projeto base já contém a estrutura necessária e dados simulados (mockados) na `CatalogStore`. Sua missão é implementar as seguintes funcionalidades:

- **Visualização de Categorias e Itens:**
  - Exibir as categorias e seus itens correspondentes, com destaque para a categoria ativa.
  - Inicialmente, mostrar apenas **duas linhas de categorias**. A lista completa deve ser exibida ao clicar no botão "+ ver mais".

- **Busca Inteligente:**
  - Implementar a funcionalidade de busca que filtra as categorias. A busca deve retornar as categorias cujo nome corresponda ao termo buscado ou que contenham itens com o termo em seus nomes.

- **Responsividade e Interatividade:**
  - O design fornecido no Figma inclui layouts para desktop e mobile. Todo o código deve ser responsivo, adaptando-se corretamente ao redimensionamento da janela.
  - Para garantir uma boa experiência em aplicativos desktop, implemente os **estados visuais** para interações como **cliques, hover e seleção**.

## Requisitos

- Desenvolvimento para **Flutter no Windows**.
- **Utilização das bibliotecas** e recursos já presentes no projeto.
- Interface **responsiva** (desktop e mobile).
- **Estados visuais** claros para interações.
- Adesão completa ao **design do Figma** (incluindo espaçamento, tipografia e cores).

## Como Executar o Projeto

1. Clone o repositório.
2. Execute `flutter pub get` para instalar as dependências.
3. Use `flutter run` para iniciar a aplicação.

## Build para Windows

Este projeto está configurado para gerar build para a plataforma Windows. Verifique se todas as dependências específicas do Windows estão corretamente instaladas e configuradas antes de gerar o build.

## Entrega do Projeto

O candidato deve realizar um fork deste repositório, implementar as funcionalidades requeridas e enviar o link do repositório público com o código final dentro do prazo estipulado no e-mail.

## Notas

- [Link para design no Figma](https://www.figma.com/design/CUAX5R7iffWvB35mCCQ6hl/Teste-flutter---alloy?node-id=0-1&t=tBoKfYXv1RFNR8QM-1)
- Siga o design apresentado no Figma para todos os componentes visuais.
- Priorize a clareza das interações e feedbacks visuais ao usuário.

## Critérios de Avaliação

- Implementação correta das visualizações e estados da interface.
- Adesão ao design proposto no Figma, incluindo detalhes de hovers, seleções e responsividade.
- Qualidade do código, com nomenclatura clara para funções e variáveis.
- Reutilização de componentes, classes, extensões e temas disponíveis no projeto.
