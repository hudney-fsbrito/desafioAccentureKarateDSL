Feature: Deletar um usuario

  Background:
    Given url baseUrl
    * def setupData = callonce read('classpath:features/01_setup/01_setup-completo.feature')
    * def userID = setupData.usuarioID
    * def token = setupData.token

  @deletarUsuario @all
  Scenario: Deletar um usuario com sucesso
    * def userId =  read('classpath:features/02_conta/dadosConta/dados-salvos-usuario.json>')
    * def ID = userId.userId

    When path /Account/v1/User/ + userID
    And header Authorization = 'Bearer ' + token
    And method delete
    Then status 200