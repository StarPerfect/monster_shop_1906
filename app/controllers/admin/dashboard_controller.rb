class Admin::DashboardController < ApplicationController

  def show
    @orders = Order.sorted
  end

  def user_show
    @user = User.find(params[:id])
  end

  def ship
    order = Order.find(params[:format])
    x = order.update(status: 2)
    redirect_to "/admin"
  end

  def index
    @merchants = Merchant.all
  end

  def able
    merchant = Merchant.find(params[:id])
    if merchant.enabled? == true
      merchant.update(enabled: false)
    else
      merchant.update(enabled: true)
    end
    redirect_to "/admin/merchants"
  end
end
