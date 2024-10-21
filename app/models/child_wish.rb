class ChildWish < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :present
end
