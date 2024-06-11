class Material < ApplicationRecord
  has_many :logs

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1, message: ": Only values greater than 0 are allowed" }

  validate :removal_time_restriction, on: :removal

  def removal_time_restriction
    if Time.current.on_weekend? || !(9..18).include?(Time.current.hour)
      errors.add(:base, "Removal is only permitted between 9am and 6pm on weekdays")
    end
  end

  def add_quantity(user, quantity)
    if quantity > 0
      self.quantity += quantity
      if self.save
        logs.create(user: user, quantity: quantity, action_type: 'add')
        return true
      else
        errors.add(:base, "Invalid operation.")
        return false
      end
    else
      errors.add(:base, "Quantity must be greater than 0.")
      return false
    end
  end

  def remove_quantity(user, quantity)
    if quantity <= self.quantity && quantity > 0
      self.quantity -= quantity
      if valid?(:removal) && self.save
        logs.create(user: user, quantity: quantity, action_type: 'remove')
        return true
      end
    else
      errors.add(:base, "Invalid quantity.")
      return false
    end
  end

  before_destroy :check_for_logs

  private
  def check_for_logs
    if logs.any?
      errors.add(:base, "Cannot delete material with associated logs")
      throw :abort
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name quantity]
  end

end
