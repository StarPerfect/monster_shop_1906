class ItemsController<ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
    @item_stats_top = Item.item_stats_top
    @item_stats_bottom = Item.item_stats_bottom
  end

  def show
    @item = Item.find(params[:id])
  end

end
