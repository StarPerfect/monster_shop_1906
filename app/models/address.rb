class Address < ApplicationRecord
  validates_presence_of :nickname, :street, :city, :state, :zip

  belongs_to :user#, inverse_of: :addresses
  has_many :order

  validates :user, presence: true
end
