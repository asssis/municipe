class Municipio < ApplicationRecord
  belongs_to :estado
  has_many :pessoas
end
