class Users::OrdersController < ApplicationController

  def index
    @user = current_user
    @orders = @user.orders
  end

  def create
    @user = User.find(params[:user_id])
    @address = Address.find(params[:address_id])
    order = @user.orders.create(name: @user.name, address: @address)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      flash[:notice] = "Your order has been created"
      session.delete(:cart)
      redirect_to "/profile/orders"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    @order = Order.find(params[:id])
    @order.update(status: 'cancelled')
    @order.item_orders.each do |item|
      item.status = 'unfulfilled'
    end
    @order.item_orders.update(status: 'unfulfilled')
    flash[:message] = "Success! Our Big Hangry Monster ate your order therefore it's been cancelled!"
    redirect_to profile_path
  end
end
