Feature: Autorizar

  Background:
    * def payload = karate.get('bodyRequest') || read('classpath:features/02_conta/dadosConta/dados-registro-usuario.json')
  @auth @all
  Scenario: Autorizar usuário
    #* def bodyRequest = read('classpath:features/02_conta/dadosConta/dados-registro-usuario.json')

    Given url baseUrl
    And path "/Account/v1/Authorized"
    And request payload
    When method post
    Then status 200
    * print response

