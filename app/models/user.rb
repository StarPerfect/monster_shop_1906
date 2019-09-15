class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :email

  validates :email, uniqueness: true, presence: true

  has_many :orders
  has_many :addresses, inverse_of: :user
  accepts_nested_attributes_for :addresses

  belongs_to :merchant, optional: true

  enum role: %w(default employee merchant admin)
end
