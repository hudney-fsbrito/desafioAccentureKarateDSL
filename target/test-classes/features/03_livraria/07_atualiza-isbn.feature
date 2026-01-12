Feature:

  Background:

  @atualizaIsbn @all
  Scenario: Atualiza isbn
    * def bodyRequest = read('classpath:features/03_livraria/dadosParaLivro/atualiza-isbn.json')
    * def isbnSalvo = read('classpath:features/03_livraria/dadosParaLivro/adiciona-livro-usuario.json')

    Given path "/BookStore/v1/Books" + isbnSalvo
    When method put
    And request bodyRequest
    And  isbnSalvo = segundoisbnSalvo
    Then print response
    And status 200