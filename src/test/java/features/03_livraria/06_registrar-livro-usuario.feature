Feature: Registrar livro

  Background:
    Given url baseUrl


  @registrarLivros @all
  Scenario: Adicionar livro ao usuário
    * def livros = call read('classpath:features/03_livraria/05_listar-livros.feature@all')
    * def isbn = livros.isbnSalvo

    Given path "/BookStore/v1/Books"
    And header Authorization = 'Bearer ' + token
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
    * def isbn = response.collectionOfIsbns.isbn