class Estado < ApplicationRecord
    has_many :municipios
    has_many :pessoas
end
