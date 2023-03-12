class CreatePessoas < ActiveRecord::Migration[7.0]
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :dt_nascimento
      t.string :telefone
      t.string :cep
      t.string :logradouro
      t.string :complemento
      t.string :bairro
      t.string :cod_ibge
      t.string :imagem
      t.boolean :status, :default => true
      t.references :municipio, null: false, foreign_key: true
      t.references :estado, null: false, foreign_key: true

      t.timestamps
    end
  end
end
