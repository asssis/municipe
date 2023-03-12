# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_10_134719) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "estados", force: :cascade do |t|
    t.string "cod_uf"
    t.string "uf"
    t.string "nome"
    t.string "regiao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipios", force: :cascade do |t|
    t.string "cod_ibge"
    t.string "nome"
    t.bigint "estado_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_municipios_on_estado_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "cpf"
    t.string "cns"
    t.string "email"
    t.date "dt_nascimento"
    t.string "telefone"
    t.string "cep"
    t.string "logradouro"
    t.string "complemento"
    t.string "bairro"
    t.string "cod_ibge"
    t.string "imagem"
    t.boolean "status", default: true
    t.bigint "municipio_id", null: false
    t.bigint "estado_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_pessoas_on_estado_id"
    t.index ["municipio_id"], name: "index_pessoas_on_municipio_id"
  end

  add_foreign_key "municipios", "estados"
  add_foreign_key "pessoas", "estados"
  add_foreign_key "pessoas", "municipios"
end
