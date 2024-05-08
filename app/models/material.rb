class Material < ApplicationRecord

  validates :name, presence: true, uniqueness: true
end
