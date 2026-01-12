Feature: Listar livros

  Background:
    Given url baseUrl

  @livros @all
  Scenario: Listar catálogo

    Given path "/BookStore/v1/Books"
    When method get
    Then status 200
    And print response
    And assert responseTime < 5000
    And def isbnSalvo = response.books[0].isbn
    And def segundoisbnSalvo = response.books[1].isbn

  @livros
  Scenario: Listar livro por isbn
    * def busca = call read('05_listar-livros.feature@all')
    * def isbn = busca.isbnSalvo

    Given path "/BookStore/v1/Books" + isbn
    When method get
    Then print response
    And status 200






