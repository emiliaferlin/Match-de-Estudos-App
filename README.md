<div align="center">

# 📚 Match de Estudos

**Conecte perfis de estudantes às sessões de estudo mais compatíveis com eles.**

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.7+-0175C2?style=flat&logo=dart)
![Provider](https://img.shields.io/badge/State-Provider-6DB33F?style=flat)
![Dio](https://img.shields.io/badge/HTTP-Dio-orange?style=flat)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

</div>

---

## 📖 Sobre o Projeto

**Match de Estudos** é um aplicativo mobile desenvolvido em Flutter que funciona como um sistema de compatibilidade entre estudantes e sessões de estudo. Inspirado na dinâmica de aplicativos de match, ele calcula um **score de compatibilidade** entre o perfil de um estudante (seu nível, estilo e disciplina de interesse) e uma sessão de estudo disponível (nível exigido, estilo, horário, vagas).

O resultado é um percentual de compatibilidade — se acima do limiar configurado no back-end, o match é **aprovado** e o estudante pode ingressar na sessão.

---

## ✨ Funcionalidades

- **Autenticação** — Login e cadastro com token JWT armazenado de forma segura
- **Gestão de Perfis** — Cadastrar, editar e excluir perfis de estudantes com informações como nome, idade, disciplina, nível e estilo de aprendizado
- **Gestão de Sessões** — Cadastrar, editar e excluir sessões de estudo com título, disciplina, nível, estilo, horário de início, duração e número de vagas
- **Cálculo de Match** — Selecionar um perfil e uma sessão para receber um score de 0–100 com indicação visual de aprovação
- **Histórico de Matches** — Listar todos os matches aprovados de um perfil específico

---

## 🖼️ Estrutura de Telas

```
App
├── Auth (Splash + Login / Cadastro)
└── NavigationBar
    ├── Perfis       → listagem, criação e edição de perfis
    ├── Sessões      → listagem, criação e edição de sessões
    ├── Match        → cálculo e histórico de matches
    └── Sair         → logout
```

---

## 🏗️ Arquitetura

O projeto segue o padrão **MVVM (Model-View-ViewModel)** com separação clara de responsabilidades por feature.

```
lib/
└── src/
    ├── components/              # Widgets reutilizáveis
    │   ├── campo_text/          # TextFormField customizado
    │   ├── loading/             # Indicador de carregamento
    │   ├── navigatton_bar/      # BottomNavigationBar
    │   └── notification/        # Snackbar/alertas
    │
    ├── core/
    │   ├── network/
    │   │   ├── http_client.dart     # Configuração do Dio + interceptors
    │   │   └── api_exception.dart   # Modelo de exceção da API
    │   ├── shared/
    │   │   ├── constantes.dart      # Cores e constantes globais
    │   │   └── text_style/          # Sistema de tipografia (TextStyleMatchEstudo)
    │   └── storage/
    │       └── auth_storage.dart    # Armazenamento seguro do token JWT
    │
    └── features/
        ├── login/               # Autenticação
        │   ├── model/
        │   ├── repository/
        │   ├── view/
        │   └── viewmodel/
        ├── perfil/              # Gestão de perfis
        │   ├── model/
        │   ├── repository/
        │   ├── view/
        │   └── viewmodel/
        ├── sessao/              # Gestão de sessões
        │   ├── model/
        │   ├── repository/
        │   ├── view/
        │   └── viewmodel/
        └── match/               # Lógica de match
            ├── model/
            ├── repository/
            ├── view/
            └── viewmodel/
```

### Fluxo de dados

```
View  ──watch──▶  ViewModel  ──call──▶  Repository  ──HTTP──▶  API REST
  ▲                   │                                           │
  └──notifyListeners──┘◀────────────── MatchModel / List ────────┘
```

---

## 🔌 Camada de Rede

### HttpClient (`core/network/http_client.dart`)

Singleton construído com **Dio**, configurado com:

| Parâmetro | Valor |
|---|---|
| Base URL | `http://10.0.2.2:8080` (emulador Android → localhost) |
| Connect Timeout | 10 segundos |
| Receive Timeout | 10 segundos |
| Content-Type | `application/json` |

Dois interceptors são registrados automaticamente:

**`_AuthInterceptor`** — injeta o token JWT no header de toda requisição:
```
Authorization: Bearer <token>
```

**`_ErrorInterceptor`** — centraliza o tratamento de erros HTTP, mapeando códigos de status para mensagens amigáveis em português:

| Status | Comportamento |
|---|---|
| 400 | Mensagem do servidor ou "Requisição inválida." |
| 401 | Limpa o token salvo + mensagem de sessão expirada |
| 403 | "Acesso negado." |
| 404 | "Recurso não encontrado." |
| 500 | "Erro interno do servidor." |
| Timeout | "Tempo de conexão esgotado." |
| Sem rede | "Sem conexão com o servidor." |

---

## 📦 Modelos de Dados

### PerfilModel

| Campo | Tipo | Descrição |
|---|---|---|
| `id` | `int?` | Identificador único |
| `nome` | `String?` | Nome completo do estudante |
| `idade` | `int?` | Idade |
| `disciplina` | `String?` | Área de interesse (ex: Matemática) |
| `nivel` | `String?` | `Iniciante` / `Intermediário` / `Avançado` |
| `estilo` | `String?` | `Silencioso` / `Colaborativo` / `Argumentativo` / `Visual` |

### SessaoModel

| Campo | Tipo | Descrição |
|---|---|---|
| `id` | `int?` | Identificador único |
| `titulo` | `String?` | Nome da sessão |
| `disciplina` | `String?` | Disciplina abordada |
| `nivel` | `String?` | Nível exigido |
| `estilo` | `String?` | Estilo de estudo da sessão |
| `dataHoraInicio` | `String?` | Data e hora de início (ISO 8601) |
| `duracaoMinutos` | `int?` | Duração em minutos |
| `vagas` | `int?` | Número de vagas disponíveis |

### MatchModel

| Campo | Tipo | Descrição |
|---|---|---|
| `id` | `int?` | Identificador do match |
| `perfilId` | `int?` | ID do perfil participante |
| `sessaoId` | `int?` | ID da sessão avaliada |
| `score` | `int?` | Compatibilidade de 0 a 100 |
| `aprovado` | `bool?` | `true` se o match foi aprovado |

---

## 🔗 Endpoints Consumidos

| Método | Endpoint | Descrição |
|---|---|---|
| `POST` | `/matches` | Calcula o score entre um perfil e uma sessão |
| `GET` | `/perfis/{id}/matches` | Lista os matches aprovados de um perfil |
| `GET` | `/perfis` | Lista todos os perfis cadastrados |
| `GET` | `/sessoes` | Lista todas as sessões disponíveis |
| `POST` | `/perfis` | Cria um novo perfil |
| `PUT` | `/perfis/{id}` | Atualiza um perfil existente |
| `DELETE` | `/perfis/{id}` | Remove um perfil |
| `POST` | `/sessoes` | Cria uma nova sessão |
| `PUT` | `/sessoes/{id}` | Atualiza uma sessão existente |
| `DELETE` | `/sessoes/{id}` | Remove uma sessão |

---

## 🎨 Design System

O app possui um design system próprio definido em `core/shared/`:

**Cor primária:** `Color(0xFFA23909)` — terracota escuro

**Tipografia:** Família `Lato`, com dois pesos base:
- Body (`w400`): `bodyXXS` (10) → `bodyXXXL` (24)
- Title (`w900`): `titleXXS` (12) → `titleXXL` (48)

Todos os estilos são acessados via `TextStyleMatchEstudo.<variante>(color: ...)`, garantindo consistência tipográfica em toda a aplicação.

---

## 📐 Gerenciamento de Estado

Utiliza **Provider** (`^6.1.5`) com `ChangeNotifier`. Cada feature possui seu próprio ViewModel registrado acima da árvore de widgets:

```dart
// Exemplo de consumo
final vm = context.watch<MatchViewmodel>(); // reconstrói ao mudar
context.read<MatchViewmodel>().calcularMatch(perfilId, sessaoId); // apenas lê/chama
```

Os ViewModels gerenciam estados de loading separados por operação (`loadingCalc`, `loadingList`) para que diferentes partes da UI possam reagir de forma independente.

---

## 🔒 Segurança

O token JWT é persistido com **flutter_secure_storage** (`^9.0.0`), que utiliza:
- **Android:** Android Keystore
- **iOS:** Keychain

Em caso de resposta 401 da API, o token é removido automaticamente pelo `_ErrorInterceptor`, forçando o usuário a realizar novo login.

---

## 🚀 Como executar

### Pré-requisitos

- Flutter SDK `^3.7.0`
- Dart `^3.7.0`
- Emulador Android ou dispositivo físico
- Back-end rodando na porta `8080` da máquina host

### Passo a passo

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/match-estudos-app.git
cd match-estudos-app

# 2. Instale as dependências
flutter pub get

# 3. Execute o app (emulador Android)
flutter run
```

> **Nota:** A URL base `http://10.0.2.2:8080` é o alias do emulador Android para `localhost`. Caso rode em dispositivo físico ou iOS, atualize `_baseUrl` em `lib/src/core/network/http_client.dart` para o IP da sua máquina na rede local.

---

## 📦 Dependências Principais

| Pacote | Versão | Uso |
|---|---|---|
| `provider` | `^6.1.5` | Gerenciamento de estado (MVVM) |
| `dio` | `^5.9.2` | Cliente HTTP com interceptors |
| `flutter_secure_storage` | `^9.0.0` | Armazenamento seguro do token JWT |
| `intl` | `^0.19.0` | Formatação de datas e internacionalização |
| `brasil_fields` | `1.15.0` | Formatação de campos com máscaras brasileiras |
| `animated_splash_screen` | `^1.3.0` | Tela de splash animada |
| `animated_snack_bar` | `^0.4.0` | Notificações animadas |
| `flutter_progress_loading` | `^0.0.6` | Overlay de carregamento global |

---

## 📁 Padrão de Nomenclatura

| Camada | Sufixo | Exemplo |
|---|---|---|
| Model | `_model` | `match_model.dart` |
| View | `_view` | `match_view.dart` |
| ViewModel | `_viewmodel` | `match_viewmodel.dart` |
| Repository | `_repository` | `match_repository.dart` |
| Form | `_form_view` | `perfil_form_view.dart` |

---

<div align="center">
Feito com ❤️ e Flutter
</div>
