class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
      @cart_items = current_customer.cart_items.all
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] = "商品を削除しました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "商品を削除できませんでした。"
      render 'index'
    end
  end

  def destroy_all
    if current_customer.cart_items.destroy_all
      flash[:notice] = "全ての商品を削除しました。"
      redirect_to request.referer
    else
      render 'index'
    end
  end

  def create
    @cart_item = current_user.cart_items.build(cart_item_params)
    @cart_items = current_user.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_quantity = cart_item.quantity + @cart_item.quantity
        cart_item.update_attribute(:quantity, new_quantity)
        @cart_item.delete
      end 
    end
    @cart_item.save
    redirect_to :cart_items
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
