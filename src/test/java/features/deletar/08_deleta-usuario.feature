Feature: Deletar um usuario

  Background:
    Given url baseUrl
  @deletarUsuario @all
  Scenario: Deletar um usuario com sucesso
    * def userId =  read('classpath:features/02_conta/dadosConta/dados-salvos-usuario.json>')
    * def ID = userId.userId

    When path /Account/v1/User/{UUID}
    And method delete
    Then status 200