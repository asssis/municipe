json.extract! pessoa, :id, :nome, :cpf, :cns, :email, :dt_nascimento, :telefone, :cep, :logradouro, :complemento, :bairro, :created_at, :updated_at
json.url pessoa_url(pessoa, format: :json)
