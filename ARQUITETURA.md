# Relatório de Migração Arquitetural – Etapa 4

## 1. Mapeamento de Classes e Widgets

| Elemento (DartPad)                  | Novo local                                  | Camada    |
|-------------------------------------|---------------------------------------------|-----------|
| Classe de usuário                   | lib/models/usuario.dart                     | Model     |
| Classe de documento                 | lib/models/documento.dart                   | Model     |
| Armazenamento em memória            | lib/models/services/banco_local_service.dart | Model    |
| Lógica de login e cadastro          | lib/viewmodels/auth_viewmodel.dart          | ViewModel |
| Carregamento da lista de documentos | lib/viewmodels/documentos_viewmodel.dart    | ViewModel |
| Validações de nome, e-mail e senha  | lib/utils/validadores.dart                  | Utils     |
| Tela de login                       | lib/views/login_view.dart (rota `/`)        | View      |
| Tela de cadastro                    | lib/views/cadastro_view.dart (`/cadastro`)  | View      |
| Tela home / lista                   | lib/views/home_view.dart (`/home`)          | View      |
| Tela de edição (preparatória)       | lib/views/editor_view.dart (`/editor`)      | View      |
| MaterialApp, tema e rotas           | lib/main.dart                               | Entrada   |

## 2. Alterações de Estrutura e Imports

- **Construtores:** as views passaram a receber o ViewModel por construtor
  (ex.: `LoginView(authViewModel: ...)`), com parâmetros `required`.
- **Instanciação:** os ViewModels são criados uma única vez no `main.dart` e
  compartilhados entre as telas.
- **Imports:** cada arquivo importa só o que usa, com caminhos relativos
  (ex.: `../utils/validadores.dart`, `../viewmodels/auth_viewmodel.dart`).
- **Visibilidade:** o estado interno dos ViewModels ficou privado (`_documentos`,
  `_carregando`, `_mensagem`) e é exposto por getters, como `documentos`.
- **Rotas nomeadas:** `/`, `/cadastro`, `/home` e `/editor` configuradas em
  `routes` no `main.dart`, com navegação por `Navigator.pushNamed`.

## 3. Mudanças no Gerenciamento de Estado

- **setState mantido:** `_mostrarSenha` (login e cadastro) continua com
  `setState`, por ser estado puramente visual e local da tela.
- **Estado nos ViewModels (ChangeNotifier):** `DocumentosViewModel` guarda
  `_documentos`, `_carregando` e `_mensagem`; `AuthViewModel` guarda o resultado
  das operações e a mensagem de erro.
- **Como as telas reagem:** a `HomeView` usa `ListenableBuilder` escutando o
  `DocumentosViewModel`. Quando o ViewModel chama `notifyListeners()`
  (em `carregarDocumentos`, por exemplo), o builder reconstrói a tela e exibe
  carregando, erro ou a lista.
