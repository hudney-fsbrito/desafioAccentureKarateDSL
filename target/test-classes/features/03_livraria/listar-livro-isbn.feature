Feature:  Listar livro por isbn

  Background:
    Given url baseUrl

  @livros
  Scenario: Listar livro por isbn
    * def busca = call read('classpath:features/03_livraria/05_listar-livros.feature@catalogo')
    * def isbn = busca.isbnSalvo
    * print busca
    * print isbn

    Given path "/BookStore/v1/Book"
    And param ISBN = isbn
    When method get
    Then status 200
    And print response
    And match response.isbn == isbn