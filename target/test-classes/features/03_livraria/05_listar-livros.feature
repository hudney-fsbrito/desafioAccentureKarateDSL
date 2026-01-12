Feature: Listar livros

  Background:
    Given url baseUrl

  @livros @catalogo
  Scenario: Listar catálogo

    Given path "/BookStore/v1/Books"
    When method get
    Then status 200
    And print response
    And assert responseTime < 5000
    And def isbnSalvo = response.books[0].isbn
    And def segundoisbnSalvo = response.books[1].isbn

    * def resultadoLivro =
    """
    {
      "isbnSalvo": "#(isbnSalvo)",
      "segundoisbnSalvo": "#(segundoisbnSalvo)"
    }
    """
