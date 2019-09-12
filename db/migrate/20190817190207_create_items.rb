class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :image, default: "https://www.celladorales.com/wp-content/uploads/2016/12/ShippingBox_sq.jpg"
      t.boolean :active?, default: true
      t.integer :inventory
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
