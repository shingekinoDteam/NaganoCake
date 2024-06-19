class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(10)
    @genres = Genre.all
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
      flash.now[:alert] = "投稿に失敗しました。エラー: #{@item.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_items_path
    else
      flash.now[:alert] = "編集に失敗しました。エラー: #{@item.errors.full_messages.join(', ')}"
      render :new
    end

  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
  end
end