class Address < ApplicationRecord
  validates_presence_of :nickname, :street, :city, :state, :zip

  belongs_to :user#, inverse_of: :addresses
  has_many :orders

  validates :user, presence: true

  def has_shipped_orders?
    self.orders.pluck(:status).any?{ |status| status == 'shipped' }
  end
end
