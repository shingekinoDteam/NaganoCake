class Public::ItemsController < ApplicationController
  def index
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @itesm = Item.find(params[:id])
    @genres = Genre.all
  end
end
