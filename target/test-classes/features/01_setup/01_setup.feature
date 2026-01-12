Feature: Setup para teste geral

  @TesteGeral
  Scenario: Cadastra usuario, gera o token e autoriza usuario
    * def nome = Java.type('features.support.utils.Utils').gerarNomeFake()
    * def senha = Java.type('features.support.utils.Utils').gerarSenha()
    * def senhaFinal = "M!n2" + senha

    * def bodyRequest = read('classpath:features/dadosConta/dados-registro-usuario.json')
    * def bodyRequest =
    """
      {
      "userName": "#(nome)",
      "password": "#(senhaFinal)"
      }
    """


    Given url baseUrl
    And path "/Account/v1/User"
    And request bodyRequest
    When method post
    Then status 201
    And print response
    And def usuarioID = response.userID
    And print usuarioID
    * print bodyRequest

    Given url baseUrl
    And path "/Account/v1/GenerateToken"
    And request bodyRequest
    * print bodyRequest
    When method post
    Then response.token != null
    * print response
    * def token = response.token
    * print token

    Given url baseUrl
    And path "/Account/v1/Authorized"
    And request bodyRequest
    When method post
    Then status 200
    * print response

    * def livros = call read('classpath:features/03_livraria/05_listar-livros.feature')
    * def isbn = livros.isbnSalvo
    * print 'ISBN selecionado:', isbn

    * Karate.set('globalUserID', usuarioID)
    * karate.set('globalUserName', nome)
    * karate.set('globalSenha', senhaFinal)
    * karate.set('globalToken', token)
    * karate.set('globalBodyRequest', bodyRequest)

    * def result =
    """
    {
      usuarioID: '#(usuarioID)',
      userName: '#(nome)',
      password: '#(senhaFinal)',
      token: '#(token)',
      bodyRequest: #(bodyRequest),
      isbn: '#(isbn)'
    }
    """

    * print result
    * return result