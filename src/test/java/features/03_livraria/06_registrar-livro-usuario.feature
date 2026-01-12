Feature: Registrar livro

  Background:
    Given url baseUrl
    * def setupData = callonce read('classpath:features/01_setup/01_setup.feature@TesteGeral')
    * def userID = setupData.usuarioID
    * def token = setupData.token
    * def isbn = setupData.isbn


  @registrarLivros @all
  Scenario: Adicionar livro ao usuário


    Given path "/BookStore/v1/Books"
    And header Authorization = 'Bearer ' + token
    And header Content-Type = 'application/json'
    And request
    """
      {
        userId: "#(userID)",
        collectionOfIsbns: [
          { isbn: "#(isbn)" }
        ]
      }
    """
    When method post
    Then status 201
    And print response
    And assert responseTime < 5000
    And match response.books[0].isbn == isbn
    * def isbnRegistrado = response.books[0].isbn