class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def subtotal
    price * quantity
  end
end
