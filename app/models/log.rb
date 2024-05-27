class Log < ApplicationRecord
  belongs_to :user
  belongs_to :material

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :action_type, presence: true, inclusion: { in: %w[add remove] }

end
