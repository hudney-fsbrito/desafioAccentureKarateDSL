#  Desafio Accenture — Automação de Testes de API com Karate DSL

![Karate](https://img.shields.io/badge/Testes-Karate%20DSL-brightgreen)
![Java](https://img.shields.io/badge/Java-11+-orange)
![JUnit5](https://img.shields.io/badge/JUnit-5-blue)
![BDD](https://img.shields.io/badge/BDD-Gherkin-yellow)

Este repositório contém uma suíte de **testes automatizados de API** desenvolvida com **Karate DSL**, utilizando **BDD (Gherkin)** e **JUnit 5**, simulando um fluxo real de negócio sobre a API **BookStore (DemoQA)**.

O projeto foi estruturado para demonstrar boas práticas de automação, reutilização de cenários, controle de estado (token, userId, isbn) e execução sequencial de testes E2E.

---

##  Objetivo do Projeto

Validar, de forma automatizada, o fluxo completo de uma aplicação REST:

- Cadastro de usuário
- Autorização
- Geração de token JWT
- Consulta de catálogo de livros
- Registro de livros para um usuário
- Atualização de dados
- Exclusão de usuário (cleanup)

Tudo isso utilizando **features reutilizáveis** e um **setup centralizado**.

---

##  Estrutura do Projeto

```text
src/test/java/features
│
├── 01_setup/
│   └── 01_setup.feature
│
├── 02_conta/
│   ├── 02_cadastrar-usuario.feature
│   ├── 03_gerar-token.feature
│   ├── 04_autorizar-usuario.feature
│   └── 08_deletar-usuario.feature
│
├── 03_livraria/
│   ├── 05_listar-livros.feature
│   ├── 06_registrar-livro-usuario.feature
│   └── 07_atualizar-isbn.feature
│
├── support/
│   └── utils/
│       └── Utils.java
│
└── runners/
    ├── KarateParallelRunner.java
    └── KarateE2ERunner.java
```

---

## Setup de Testes
No setup é a base do fluxo de automação, responsável por preparar todos os dados necessários para execução dos testes. Funciona em 4 etapas: 

Geração de dados dinâmicos  

Cria usuários únicos para evitar conflitos Cadastro na API 

Registra o usuário e armazena seu ID

Autenticação 

Obtém token JWT para requisições autorizadas

Obtenção de livros 

Seleciona ISBNs válidos do catálogo

Fluxo: Dados → Cadastro → Autenticação → Livros → Retorno

Retorno: Objeto JSON com todos os dados necessários para os testes subsequentes.

Benefícios:

* Isolamento entre testes

* Reutilização de código

* Performance otimizada (execução única por thread)

* Cleanup automático no final do fluxo

O setup garante que cada teste inicie de um estado consistente, aumentando a confiabilidade dos resultados.

##  Fluxo de Execução (E2E)

O fluxo completo segue a seguinte ordem:

1. Criar usuário
2. Autorizar usuário
3. Gerar token
4. Buscar livros disponíveis
5. Registrar livro para o usuário
6. Atualizar ISBN
7. Deletar usuário

Esse fluxo é controlado pelo arquivo:

```
features/01_setup/01_setup.feature
```

---

##  Compartilhamento de Dados entre Features

O Karate **não mantém estado entre features automaticamente**. Por isso, este projeto utiliza:

- `call` e `callonce`
- Retorno de objetos entre features
- Setup centralizado

### Exemplo:

```gherkin
* def cadastro = call read('02_cadastrar-usuario.feature')
* def userID = cadastro.usuarioID
* def token = cadastro.token
```

Assim, o **mesmo usuário** é reutilizado durante todo o fluxo de testes.

---

##  Autenticação e Autorização

Alguns endpoints exigem autenticação via JWT.

Exemplo de uso do token:

```gherkin
And header Authorization = 'Bearer ' + token
```

A geração do token ocorre apenas **após o cadastro e autorização do usuário**, respeitando a regra de negócio da API.

---

##  Registro de Livro

Para registrar um livro, são necessários:

- `userId`
- `token`
- `isbn`

Exemplo de payload:

```json
{
  "userId": "<USER_ID>",
  "collectionOfIsbns": [
    { "isbn": "<ISBN>" }
  ]
}
```

O ISBN é obtido dinamicamente a partir do endpoint de listagem de livros.

---

## ️ Execução dos Testes

### ▶ Runner Paralelo (por tags)

```java
Results results = Runner
    .path("classpath:features")
    .tags("@ListaUsuario")
    .parallel(5);
```
### ▶ Runner Paralelo EM SEQUÊNCIA (por tags)

```java
Results results = Runner
    .path("classpath:features")
    .tags("@ListaUsuario@TesteGeral,@registrarLivros,@atualizaIsbn,@deletarUsuario")
    .parallel(5);
```

### ▶ Runner Sequencial (E2E)

```java
import com.intuit.karate.junit5.Karate;

public class KarateE2ERunner {

    @Karate.Test
    Karate runE2E() {
        return Karate.run(
            "classpath:features/01_setup/01_setup.feature",
            "classpath:features/03_livraria/06_registrar-livro-usuario.feature",
            "classpath:features/03_livraria/07_atualizar-isbn.feature",
            "classpath:features/02_conta/08_deletar-usuario.feature"
        );
    }
}
```

---

##  Tecnologias Utilizadas

- **Karate DSL**
- **Java 11+**
- **JUnit 5**
- **Gherkin (BDD)**
- **REST APIs**

---

##  Boas Práticas Aplicadas

✔ Modularização de cenários
✔ Setup centralizado
✔ Reutilização de features
✔ Separação por domínio (conta / livraria)
✔ Limpeza de dados ao final do teste
✔ Execução controlada por runner

---

##  Possíveis Evoluções

- Testes negativos e de contrato
- Testes de performance com Karate

---

##  Autor

**Hudney Brito**  
Projeto desenvolvido como desafio técnico e estudo avançado de automação de testes de API com Karate DSL.

---

 *Karate DSL permite criar testes claros, reutilizáveis e poderosos — este projeto demonstra isso na prática.*

