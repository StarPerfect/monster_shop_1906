class RemoveZipFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :zip, :string
  end
end
