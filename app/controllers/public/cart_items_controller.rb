class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.amount * item.item.with_tax_price }
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "数量が更新されました。"
    else
      flash[:alert] = "数量の更新に失敗しました。"
    end
    redirect_to cart_items_path
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
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
      redirect_to cart_items_path
    else
      flash.now[:alert] = "全ての商品を削除できませんでした。"
      render 'index'
    end
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    existing_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)

    if existing_cart_item
      existing_cart_item.amount += @cart_item.amount
      @cart_item.destroy
      existing_cart_item.save
    else
      @cart_item.save
    end

    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end