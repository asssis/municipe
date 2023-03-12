require 'net/http'
class PessoasController < ApplicationController
  before_action :set_pessoa, only: %i[ show edit update ]

  # GET /pessoas or /pessoas.json
  def index
    @filter = params[:filter]
    if(@filter.blank?)
      @pessoas = Pessoa.all.order(nome: :asc).page(1)
    else
      @pessoas = Pessoa.__elasticsearch__.search(@filter).page(1).records
    end
  end

  # GET /pessoas/1 or /pessoas/1.json
  def show
  end

  # GET /pessoas/new
  def new
    @pessoa = Pessoa.new
    @municipios = []
  end

  # GET /pessoas/1/edit
  def edit
    @municipios =  Municipio.where(estado_id: @pessoa.estado_id)
                            .map{|x| {id: x.id, nome: x.nome, cod_ibge: x.cod_ibge}}
  end

  # POST /pessoas or /pessoas.json
  def create
    @pessoa = Pessoa.new(pessoa_params)
    @municipios = Municipio.where(estado_id: @pessoa.estado_id)

    respond_to do |format|
      if @pessoa.save
        format.html { redirect_to pessoa_url(@pessoa), notice: "Pessoa was successfully created." }
        format.json { render :show, status: :created, location: @pessoa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  def consulta_cep
    render json: get_cep(params[:cep])
  end

  def consultar_municipio 
    render json:  Municipio.where(estado_id: params[:id])
                           .map{|x| {id: x.id, nome: x.nome, cod_ibge: x.cod_ibge}}
  end

  # PATCH/PUT /pessoas/1 or /pessoas/1.json
  def update
    respond_to do |format|
      if @pessoa.update(pessoa_params)
        format.html { redirect_to pessoa_url(@pessoa), notice: "Pessoa was successfully updated." }
        format.json { render :show, status: :ok, location: @pessoa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pessoa.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_cep(cep)
      begin
        json = Net::HTTP.get(URI.parse("https://viacep.com.br/ws/#{cep}/json/"))
        json = JSON.parse(json)
        
        json[:estado] = Estado.where(uf: json["uf"]).map{|x| {id: x.id, nome: x.nome, uf: x.uf}}.first
        return json
      rescue
        nil
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_pessoa
      @pessoa = Pessoa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pessoa_params
      params.require(:pessoa).permit(:nome, :cpf, :cns, :email, :dt_nascimento, :telefone, :cep, :logradouro, :complemento, :bairro, :estado_id, :municipio_id, :cod_ibge, :imagem)
    end
end
