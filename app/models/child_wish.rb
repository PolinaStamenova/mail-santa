class ChildWish < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :present

  # Scopes
  scope :from_this_year, -> { where('extract(year from child_wishes.created_at) = ?', Date.today.year) }
end
