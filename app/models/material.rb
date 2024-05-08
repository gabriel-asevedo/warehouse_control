class Material < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0, message: ": Only values greater than 0 are allowed" }

end
