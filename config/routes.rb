Rails.application.routes.draw do
  resources :pessoas
  get "/consulta_cep/:cep", to: "pessoas#consulta_cep"
  get "/consultar_municipio/:id", to: "pessoas#consultar_municipio"
  root :to => "pessoas#index"
end
