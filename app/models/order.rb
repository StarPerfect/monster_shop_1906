class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  belongs_to :address
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: ["pending", "packaged", "shipped", "cancelled"]

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def self.sorted
    self.order(:status)
  end

  def all_done?
    item_orders.all? { |item_order| item_order.fulfilled? == true }
  end


  def total_items_in_this_order(merchant)
    items.where(merchant_id: merchant.id).sum(:quantity)

  end

  def total_value(merchant)
    a = items.where(merchant_id: merchant.id).pluck(:price, :quantity).flatten
    a.first * a.last
  end

end
