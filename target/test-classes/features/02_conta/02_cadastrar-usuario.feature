Feature: Cadastro usuarios

  Background:

  @registrarUsuario @all
  Scenario: Cadastro usuario
    * def nome = Java.type('features.support.utils.Utils').gerarNomeFake()
    * print nome
    * def senha = Java.type('features.support.utils.Utils').gerarSenha()
    * def senhaFinal = "M!n2" + senha
    * print senha
    * def bodyRequest = read('classpath:features/dadosConta/dados-registro-usuario.json')
    * set bodyRequest.userName = nome
    * set bodyRequest.password = senhaFinal
#    * def fakeUser = faker.name().username()
 #   * def fakePassword = faker.internet().password(10, 20, true, true, true)

    #* def token = callonce read('classpath:features/02_conta/03_gerar-token.feature')

    Given url baseUrl
    And path "/Account/v1/User"
    And request bodyRequest
    When method post
    Then status 201
    And print response
    And def usuarioID = response.userID
    And print usuarioID
    * print bodyRequest
