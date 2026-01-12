Feature: Gerar token para autenticação

  Background:

  @token @all
  Scenario: Gerar token
    * def bodyRequest = read('classpath:features/dadosConta/dados-registro-usuario.json')

    Given url baseUrl
    And path "/Account/v1/GenerateToken"
    And request bodyRequest
    * print bodyRequest
    When method post
    Then response.token != null
    * print response
    * def token = response.token
    * print token
