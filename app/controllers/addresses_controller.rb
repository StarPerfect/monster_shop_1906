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
  end

  private
  # <%= link_to "Delete #{address.nickname} Address", delete_user_address(@user.id,address.id), method: :delete %>
  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end
end
