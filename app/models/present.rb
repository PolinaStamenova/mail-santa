class Present < ApplicationRecord
  # Enum for the size of the present
  enum size: { small: 0, medium: 1, large: 2 }

  # Associations
  has_one :child_wish
  has_one :user, through: :child_wish

  # Validations
  validates :name, presence: true
  validates :color, presence: true
  validates :size, presence: true, inclusion: { in: sizes.keys }

  # Methods
  def self.create_from_letter(message)
    # Use the OpenAiService to extract the present details from a message
    openai_service = OpenAiService.new
    present_details = openai_service.extract_present_details(message)

    return false if present_details.nil?

    present = Present.new(
      name: present_details['present_name'],
      color: present_details['present_color'],
      size: present_details['present_size']
    )

    present.save ? present : nil
  end
end
