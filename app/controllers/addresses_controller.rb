class AddressesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @addresses = User.find(params[:user_id]).addresses
  end

  def new
    @user = User.find(params[:user_id])
    @address = Address.new
  end

  def create
    @user = User.find(params[:user_id])
    @user.addresses << Address.create(address_params)
    redirect_to user_addresses_path(@user)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to user_addresses_path(@address.user)
  end

  def destroy
    @address = Address.find(params[:id])
    @user = @address.user
    @address.destroy
    redirect_to user_addresses_path(@user)
  end

  private

  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end
end
