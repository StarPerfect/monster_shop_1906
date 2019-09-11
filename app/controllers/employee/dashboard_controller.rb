class Employee::DashboardController < ApplicationController

  def show
    @user = current_user
    @orders = Order.all
    if @user.role == 1 || 2
      @merchant = Merchant.find(@user.merchant_id)
    end
  end

  def index
    @user = current_user
    @merchant = Merchant.find(@user.merchant_id)
  end

  def order_show
    @merchant = Merchant.find(current_user.merchant_id)
    @order = Order.find(params[:id])
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

end
