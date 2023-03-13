Rails.application.routes.draw do
  resources :pessoas
  get "/consulta_cep/:cep", to: "pessoas#consulta_cep"
  get "/consultar_municipio/:id", to: "pessoas#consultar_municipio"
  get "/alterar_status/:id", to: "pessoas#alterar_status"
  root :to => "pessoas#index"
end
