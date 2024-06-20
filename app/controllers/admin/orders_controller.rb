class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order_detail =  OrderDetail.find(params[:id])
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

   def update
    # if params[:order][:status] == "confirm_payment"
    #   @order =  Order.find(params[:id])
    #   @order.update(status:"confirm_payment")
    #   @order_details =  @order.order_details
    # 繰り返し１つずつ取り出す
    # orderdetailsの製作ステータスをupdate
    # elsif
    # 製作ステータスが製作中になったら注文ステータスを制作中に変更
    # elsif
    # 製作ステータスが製作完了になった時
    # すべての商品の製作ステータスが製作完了になった時繰り返し→if
    # else注文ステータスが発送済みになる

    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(making_status: params[:order_detail][:status])
    order = @order_detail.order
    if params[:order_detail][:making_status] == "manufacturing"
       order.update(status:"making")
    end

    if is_all_order_details_making_completed(order)
      order.update(status: 'preparing_ship')
    end

    flash[:notice] = "更新に成功しました。"
    redirect_to admin_order_path(@order_detail.order.id)
   end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def is_all_order_details_making_completed(order)
    order.order_details.each do |order_detail|
      if order_detail.making_status != 'finish'
        return false
      end
    end
    return true
  end
end
