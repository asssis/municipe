class CreateEstados < ActiveRecord::Migration[7.0]
  def change
    create_table :estados do |t|
      t.string :cod_uf
      t.string :uf
      t.string :nome
      t.string :regiao

      t.timestamps
    end
  end
end
