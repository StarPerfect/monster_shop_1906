class RemoveOrderIdFromAddresses < ActiveRecord::Migration[5.1]
  def change
    remove_reference :addresses, :order, foreign_key: true
  end
end
