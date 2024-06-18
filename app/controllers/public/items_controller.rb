class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @tax_included_price = @item.with_tax_price
    @genres = Genre.all

    if @item.nil?
      flash[:alert] = "商品が見つかりませんでした。"
      redirect_to public_items_path
    else
      render :show
    end
  end
end
