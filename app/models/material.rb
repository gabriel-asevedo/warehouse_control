class Material < ApplicationRecord

  has_many :logs

  validates :name, presence: true, uniqueness: true, length: {maximum:50}
  validates :quantity, numericality: { greater_than_or_equal_to: 0, message: ": Only values greater than 0 are allowed" }

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

end
