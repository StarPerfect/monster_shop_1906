class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :email

  # validates_presence_of :password, require: true
  validates :email, uniqueness: true, presence: true

  has_many :orders
  has_many :addresses
  belongs_to :merchant, optional: true
  enum role: %w(default employee merchant admin)
end
