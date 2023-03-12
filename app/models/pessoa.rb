class Pessoa < ApplicationRecord
    require "cpf_cnpj"
    

    include ActiveModel::Validations
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    
    belongs_to :municipio
    belongs_to :estado
    index_name([ Rails.env, Pessoa.to_s.pluralize.underscore].join( '_' ))

    mount_uploader :imagem, ImagemUploader
    validates :nome, :cpf, :cns, :dt_nascimento, :telefone, :cep, :logradouro, :bairro, :complemento, :municipio, :estado, presence: { message: 'não pode ser branco.' }
    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

    validate :validated_field 

    def municipio_nome
        municipio.nome
    end

    def estado_nome
        estado.nome
    end

    def dt_nascimento_format
        dt_nascimento.strftime("%d/%m/%Y")
    end

    def validated_field
        errors.add(:cpf, "número inválido.") unless(CPF.valid?(self.cpf))
        errors.add(:cns, "número inválido.") unless(validate_cns(self.cns))
    end

    def self.gerar_cns
        cns = Random.rand(10000000000...29999999999).to_s
        soma = 0
        pis = ""
        cns.split('').each_with_index do |val,index|
            next if(index > 10) 
            soma += val.to_i * (15 - index)  
            pis += val.to_s
        end
        resto = soma % pis.length
        resultado = ""

        dv = pis.length - resto
        dv = 0  if (dv == 11)
           
        if (dv == 10)
            soma += 2
            dv = pis.length - resto
            resultado = pis + "001" + dv.to_s            
        else
            resultado = pis + "000" + dv.to_s
        end
        return resultado
    end

    def validate_cns(cns)
        return false if (cns == nil || cns.delete(" ").length != 15)
        soma = 0
        pis = ""
        cns.split('').each_with_index do |val,index|
            next if(index > 10) 
            soma += val.to_i * (15 - index)  
            pis += val.to_s
        end
        resto = soma % pis.length
             
        if (["1", "2"].include?(pis.first))
            resultado = ""

            dv = pis.length - resto
            dv = 0  if (dv == 11)
               
            if (dv == 10)
                soma += 2
                dv = pis.length - resto
                resultado = pis + "001" + dv.to_s            
            else
                resultado = pis + "000" + dv.to_s
            end

            return cns == resultado        
        elsif(pis.first.to_i >= 7)
            return resto == 0
        end

        return false
    end
end
