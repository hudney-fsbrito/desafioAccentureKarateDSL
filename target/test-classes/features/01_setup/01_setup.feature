Feature: Setup para teste geral

  @TesteGeral
  Scenario: Preparar dados
    * def cadastro = call read('classpath:features/02_conta/02_cadastrar-usuario.feature')
    * def userID = cadastro.usuarioID
    * def userName = cadastro.nome
    * def password = cadastro.senhaFinal

    * eval java.lang.Thread.sleep(1000)

    * def autorizacao = call read('classpath:features/02_conta/04_autorizar-usuario.feature') { bodyRequest: '#(cadastro.bodyRequest)' }

    * def tokenResult = call read('classpath:features/02_conta/03_gerar-token.feature') { bodyRequest: '#(cadastro.bodyRequest)' }
    * def token = tokenResult.response.token

    * def livros = call read('classpath:features/03_livraria/05_listar-livros.feature@all')
    * def isbn = livros.isbnSalvo

    * def result =
  """
  {
    userID:   "#(userID)",
    userName: "#(userName)",
    password: "#(password)",
    token:    "#(token)",
    isbn:     "#(isbn)"
  }
  """
  * call read('classpath:features/03_livraria/06_registrar-livro-usuario.feature') { token: '#(token)', userID: '#(userID)', isbn: '#(isbn)' }

  * call read('classpath:features/03_livraria/07_atualizar-isbn.feature') { token: '#(token)', userID: '#(userID)', isbn: '#(isbn)' }

  * call read('classpath:features/02_conta/08_deletar-usuario.feature') { token: '#(token)', userID: '#(userID)' }