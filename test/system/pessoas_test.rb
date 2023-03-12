require "application_system_test_case"

class PessoasTest < ApplicationSystemTestCase
  setup do
    @pessoa = pessoas(:one)
  end

  test "visiting the index" do
    visit pessoas_url
    assert_selector "h1", text: "Pessoas"
  end

  test "should create pessoa" do
    visit pessoas_url
    click_on "New pessoa"

    fill_in "Bairro", with: @pessoa.bairro
    fill_in "Cep", with: @pessoa.cep
    fill_in "Cns", with: @pessoa.cns
    fill_in "Complemento", with: @pessoa.complemento
    fill_in "Cpf", with: @pessoa.cpf
    fill_in "Dt nascimento", with: @pessoa.dt_nascimento
    fill_in "Email", with: @pessoa.email
    fill_in "Logradouro", with: @pessoa.logradouro
    fill_in "Nome", with: @pessoa.nome
    fill_in "Telefone", with: @pessoa.telefone
    click_on "Create Pessoa"

    assert_text "Pessoa was successfully created"
    click_on "Back"
  end

  test "should update Pessoa" do
    visit pessoa_url(@pessoa)
    click_on "Edit this pessoa", match: :first

    fill_in "Bairro", with: @pessoa.bairro
    fill_in "Cep", with: @pessoa.cep
    fill_in "Cns", with: @pessoa.cns
    fill_in "Complemento", with: @pessoa.complemento
    fill_in "Cpf", with: @pessoa.cpf
    fill_in "Dt nascimento", with: @pessoa.dt_nascimento
    fill_in "Email", with: @pessoa.email
    fill_in "Logradouro", with: @pessoa.logradouro
    fill_in "Nome", with: @pessoa.nome
    fill_in "Telefone", with: @pessoa.telefone
    click_on "Update Pessoa"

    assert_text "Pessoa was successfully updated"
    click_on "Back"
  end

  test "should destroy Pessoa" do
    visit pessoa_url(@pessoa)
    click_on "Destroy this pessoa", match: :first

    assert_text "Pessoa was successfully destroyed"
  end
end
