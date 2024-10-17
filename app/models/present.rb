class Present < ApplicationRecord
  # Enum for the size of the present
  enum size: { small: 0, medium: 1, large: 2 }

  # Validations
  validates :name, presence: true
  validates :color, presence: true
  validates :size, presence: true, inclusion: { in: sizes.keys }
end
