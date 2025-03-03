class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0


  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.item_stats_top
    ItemOrder.joins(:item)
             .order(quantity: :desc)
             .limit(5)
             .pluck("items.name", :quantity)
  end

  def self.item_stats_bottom
    ItemOrder.joins(:item)
             .order(:quantity)
             .limit(5)
             .pluck("items.name", :quantity)
  end

end
