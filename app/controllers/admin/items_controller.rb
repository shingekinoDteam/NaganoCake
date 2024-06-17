class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to admin_items_path
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update

  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :is_active)
  end
end