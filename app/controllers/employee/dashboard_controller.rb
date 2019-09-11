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
    binding.pry
    
  end

end
