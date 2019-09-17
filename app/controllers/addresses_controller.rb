class AddressesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @addresses = User.find(params[:user_id]).addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def destroy
  end

  # private
  # <%= link_to "Delete #{address.nickname} Address", delete_user_address(@user.id,address.id), method: :delete %>
  # def address_params
  #   params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  # end
end
