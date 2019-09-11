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
    @order = Order.find(params[:id])
  end


  # private
  #
  # def merchant_params
  #   params.require(:user).permit(:merchant_id)
  # end

end
