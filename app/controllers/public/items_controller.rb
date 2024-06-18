class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @tax_included_price = (@item.price * 1.1).round  # 消費税込みの価格を計算

    if @item.nil?
      flash[:alert] = "商品が見つかりませんでした。"
      redirect_to public_items_path
    else
      render :show
    end
  end
end
