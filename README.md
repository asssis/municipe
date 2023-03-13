# Hospedagem

  http://34.130.20.132:3000/pessoas

# Requisitos
* Instalar o docker
* Instalar o docker-compose

# Tecnologias usadas
* Ruby 2.7.5
* Rails 7.0.4
* Bootstrap 6, CSS3, HTML5, JQUWEY 3.6.4
* ElasticSearch 7
* Kaminari
* PostgreSQL
* Docker
* DockerCompose
* GoogleCloud

# Rodar o projeto
* Dar permisão para o arquivo docker-entrypoint.sh

  `sudo chmod +777 ./docker-entrypoint.sh`
  
* Rodar o comando para iniciar as VM

  `docker-compose up`

* As migrations rodaram automaticamente com a criação do banco POSTGRES, ELASTICSEARCH E RAILS

# Apresentação

## Tela de Apresentação, foi usado bootstrap no layout, kaminari para a paginação

![index](https://user-images.githubusercontent.com/13799390/224587181-dcdb1325-b5ac-41a9-bd5e-eab991763841.png)

## Tela de Cadastro, foi colocado as validações necessarias, e fazendo uso da gem simpleform, facilita as mensagem de validações

![new validation](https://user-images.githubusercontent.com/13799390/224587184-78d0c061-fd75-42b9-bb69-b4cd22394dbe.png)

## Tela de detalhes, essa tela é apenas para a visualização dos dados.
![detalhes](https://user-images.githubusercontent.com/13799390/224587177-ee641cd3-363c-4f37-a77c-06fbbdc5dd5c.png)

## Integração Kaminari com ElasticSearch

`@pessoas = Pessoa.__elasticsearch__.search(@filter).page(1).records`

![pesquisa elastcsearch](https://user-images.githubusercontent.com/13799390/224587185-605f38ab-9628-4ffd-ad3c-90e66e44c116.png)




# Desafio
Crie um CRUD de municipes (Exceto deletar). O munícipe tem status ativo e inativo. Idealmente, só precisa ser 2 páginas: Listagem de CRUD (com opções para navegar), e o cadastro em si. 2 páginas é apenas uma sugestão, você é livre para montar o UI/UX da forma que achar melhor. 

Ter uma entidade relacionada chamada Munícipe. Essa entidade cadastrar cidadãos (pessoas) dentro de um município. As seguintes regras devem ser seguidas:

1.1 Dados do munícipe: `Nome completo, CPF, CNS(cartão nacional de saúde), Email, Data nascimento, Telefone (código do país e ddd), Foto e status`. 

1.2 Todos os dados do munícipe são obrigatórios; 

1.3 `CPF, CNS,Email` devem ser válidos; 

1.4 Tenha atenção a data de nascimento. Valide os casos impossíveis/improváveis de serem válidos; 

1.5 Foto do munícipe deve ser tamanhos diferentes para servir vários casos. Ter uma entidade relacionada chamada Endereço. Essa entidade salva o endereço relacionado ao munícipe. 

As seguintes regras devem ser seguidas: 
2.1 Campos: `CEP, Logradouro, complemento, bairro, cidade, UF e código IBGE`; 

2.2 Todos os dados são obrigatórios, exceto complemento e código IBGE; 

2.3 Em termos de MVC, existe apenas a Entidade relacional endereço. O restante é dispensável; 

Regras de negócio: 
Após criar/atualizar um munícipe, você deve mandar um Email e sms ao mesmo informando sobre o cadastro de suas informações e quando o seu status sofrer alteração; Filtrar municipes por dados dele e/ou de endereço. É livre a escolha do que deve ser feito. 

Dicas: 
UI/UX: É possível otimizar o tempo de cadastro do endereço a partir do UX.

Você deve minimizar o máximo possível a navegação do usuário. Como você faria isso? 

Backend: 
Pense que essas regras podem ser mudadas com uma frequência alta; Gostamos de otimização, setups e deploys são sempre automatizados (Docker?) Não preciso dizer que você precisa testar a maioria dos arquivos, não é mesmo? Princípios e padrões de projetos são muito bem vindos e essenciais para Seniors; Reduzir o número de chamadas ao banco de dados é essencial. 

Tools: 
Ruby, Ruby on Rails e Postgres são obrigatórios; Elasticsearch/Kafka (opcional, plus); Utilize ActionView, porém, AssetPipeline/Sprockets ou uma abordagem SPA junto ao rails; 






