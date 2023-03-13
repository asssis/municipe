require 'net/http'
file_estados = File.read('./files/estados.json')
file_municipios = File.read('./files/municipios.json')
ceps = File.read('./files/ceps.json')
imagens = ["gato_botas.png", "pato-donald.jpg", "salsicha.jpg", "scooby.jpg", "tom.jpg", "franjola.png",
"taz.png", "hortelino.png", "pernalonga.jpg", "piu_piu.jpg", "papaleguas.png", "coiote.png"]

puts "==============gravando estados e municipios================"
obj_estados = JSON.parse(file_estados)
obj_municipios = JSON.parse(file_municipios)

obj_estados = obj_estados.map {|x| {cod_uf: x["codigo_uf"], uf: x["uf"], nome: x["nome"]}}
obj_municipios = obj_municipios.map {|x| {cod_ibge: x["codigo_ibge"], cod_uf: x["codigo_uf"], nome: x["nome"]}}

obj_estados.each do |obj_estado|
    estado = Estado.find_or_create_by(obj_estado)
    
    obj_municipios_by_estados = obj_municipios.select{|x| x[:cod_uf] == obj_estado[:cod_uf]}
    obj_municipios_by_estados.each do |obj_municipio|
        obj_municipio[:estado_id] = estado.id
        obj_municipio.delete(:cod_uf)
        Municipio.find_or_create_by(obj_municipio)
    end
end


puts "==============carregando ceps================"

ceps = JSON.parse(ceps)
enderecos = []
ceps.each do |cep|
    json = Net::HTTP.get(URI.parse("https://viacep.com.br/ws/#{cep}/json/"))
    json = JSON.parse(json)
    
    estado = Estado.where(uf: json["uf"]).first
    municipio = Municipio.where(nome: json["localidade"]).first
    
    endereco = Hash.new
    endereco[:estado] = estado
    endereco[:municipio] = municipio
    endereco[:cep] = json
    enderecos << endereco 
end

puts "==============gravando municipes================"

100.times do
    begin
        endereco = enderecos[Random.rand(enderecos.length - 1)]

        pessoa = Pessoa.new
        pessoa.nome = Faker::Name.name
        pessoa.cpf = CPF.generate(true)
        pessoa.cns = Pessoa.gerar_cns
        pessoa.cep = ceps[Random.rand(ceps.length - 1)]
        pessoa.email = pessoa.nome.gsub(" ", "_")+"@email.com" 
        pessoa.dt_nascimento = Random.rand(Date.parse("1980-01-01")..Date.parse("2000-12-12"))
        pessoa.telefone = Random.rand(10..99).to_s+"9"+Random.rand(10000000..99999999).to_s 
        pessoa.cep = endereco[:cep]["cep"]
        pessoa.logradouro = endereco[:cep]["logradouro"]
        pessoa.complemento = "Proximo do ..."
        pessoa.bairro = endereco[:cep]["bairro"]
        pessoa.cod_ibge = endereco[:cep]["ibge"] 
        pessoa.municipio_id = endereco[:municipio].id
        pessoa.estado_id = endereco[:estado].id  
        imagem_andress = "./files/#{imagens[Random.rand(imagens.length - 1)]}"
        pessoa.imagem = File.open(File.join(Rails.root, imagem_andress))
        pessoa.save!
        puts "===========municipe salvo #{pessoa.id}==============="
    rescue
    end
end