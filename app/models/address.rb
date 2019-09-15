class Address < ApplicationRecord
  belongs_to :user, inverse_of: :addresses
  validates :user, presence: true 
end
