Feature:

  Background:
    Given url baseUrl
    * def setupData = callonce read('classpath:features/01_setup/01_setup.feature@TesteGeral')
    * def userID = setupData.usuarioID
    * def token = setupData.token
    * def isbnSalvo = setupData.isbn
    * def segundoisbnSalvo = '9781449365035'

  @atualizaIsbn @all
  Scenario: Atualiza isbn
    * call read('classpath:features/03_livraria/06_registrar-livro-usuario.feature@registrarLivros')
    When path "/BookStore/v1/Books/" + isbnSalvo
    And header Authorization = 'Bearer ' + token
    And header Content-Type = 'application/json'
    And request
    """
    {
      "userId": "#(userID)",
      "isbn": "#(segundoisbnSalvo)"
    }
    """
    And method put
    * def isbnSalvo = segundoisbnSalvo
    Then print response
    And status 200
    And match response.books[0].isbn == segundoisbnSalvo