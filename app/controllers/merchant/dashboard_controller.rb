class Merchant::DashboardController < ApplicationController

  def new
    merchant = current_user.merchant.id
    @merchant = Merchant.find(merchant)
    @item = @merchant.items.new
  end

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

  def item_status
    @item = Item.find(params[:format])
    if @item.active? == true
      @item.update(active?: false)
    else
      @item.update(active?: true)
    end
    redirect_to '/merchant/items'
  end

  def edit
    @item = Item.find(params[:format])
  end

  def item_update
    item = Item.find(params[:id])
    if item_params[:price].to_i <= 0 || item_params[:inventory].to_i <= 0
      flash[:error] = item.errors.full_messages.to_sentence
      render :edit
    else
      item.update(item_params)
      redirect_to '/merchant/items'
    end
  end

  def create
    if item_params[:price].to_i <= 0 || item_params[:inventory].to_i <= 0
      item = Item.new(item_params)
      flash[:error] = item.errors.full_messages.to_sentence
      render :new
    else
      item = current_user.merchant.items.create(item_params)
    end
      if item.save
        flash[:notice] = "Your new item has saved!"
        redirect_to "/merchant/items"
      else
        flash[:error] = item.errors.full_messages.to_sentence
        render :new
      end
  end

  def destroy
    Item.delete(Item.where(id: params[:format]))
    flash[:notice] = "Our big hangry monster has eaten your item!"
    redirect_to '/merchant/items'
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :image, :inventory)
  end
end
