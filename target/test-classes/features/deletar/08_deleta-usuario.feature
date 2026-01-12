Feature: Deletar um usuario

  Background:
    Given url baseUrl
    * def setupData = callonce read('classpath:features/01_setup/01_setup.feature@TesteGeral')
    * def userID = setupData.usuarioID
    * def token = setupData.token
    * print 'Preparando para deletar usuário ID:', userID

  @deletarUsuario @all
  Scenario: Deletar um usuario com sucesso



    When path "/Account/v1/User/" + userID
    And header Authorization = 'Bearer ' + token
    And method delete
    Then print response
    And assert responseStatus == 200 || responseStatus == 204