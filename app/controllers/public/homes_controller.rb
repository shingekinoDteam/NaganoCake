class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @genres = Genre.all
  end

  def about
  end
end
