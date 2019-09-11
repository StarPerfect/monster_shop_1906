class Merchant::DashboardController < ApplicationController
# require :merchant

  def show
    @user = current_user
    if @user.role == 1 || 2
      @merchant = Merchant.find(@user.merchant_id)
    end
  end

  def update
    @item_order = ItemOrder.find(params[:id])
    @order = Order.find(@item_order.order_id)
    @item = Item.find(@item_order.item_id)
    new_total = @item.inventory - @item_order.quantity
    @item.update(inventory: new_total)
    @item_order.update(status: 1)
    if @order.all_done?
      @order.update(status: 'packaged')
    end
    redirect_to merchant_order_show_path(@order)
  end

  def item_status
    @item = Item.find(params[:format])
    if @item.active? == true
      @item.update(active?: false)
    else
      @item.update(active?: true)
    end
    redirect_to '/merchant/items'
  end
end
