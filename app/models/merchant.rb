class Merchant <ApplicationRecord
  has_many :items
  has_many :users
  has_many :item_orders, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def has_inventory?(item)
    found_item = Item.find(item.item_id).inventory
    item.quantity < found_item
  end

end
