class Material < ApplicationRecord
  has_many :logs

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0, message: ": Only values greater than 0 are allowed" }

  validate :removal_time_restriction

  def removal_time_restriction
    if Time.current.on_weekend? || !(9..18).include?(Time.current.hour)
      errors.add(:base, "Removal is only permitted between 9am and 6pm on weekdays")
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
    %w[name]
  end

end
