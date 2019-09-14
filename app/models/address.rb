class Address < ApplicationRecord
  belongs_to :user
  validates_presence_of :nickname, :street, :city, :state, :zip

  enum role: %w(home shipping billing) # we want to let the user give each address a nickname which defines the role somehow?
end
