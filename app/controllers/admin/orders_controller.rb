class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "confirm_payment"
        @order.order_details.update_all(making_status: "waiting_manufacture")
      end
      if @order.status == "finish_prepare"
        flash[:notice] = "注文ステータスを更新しました"
        redirect_to admin_order_path(@order)
      else
        update_order_status(@order)
        flash[:notice] = "注文ステータスを更新しました"
        redirect_to admin_order_path(@order)
      end
    else
      flash[:alert] = "注文ステータスの更新に失敗しました"
      render :show
    end
  end

  def update_order_detail
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      @order = @order_detail.order
      update_order_status(@order)
      flash[:notice] = "製作ステータスを更新しました"
      redirect_to admin_order_path(@order)
    else
      @order = @order_detail.order
      @order_details = @order.order_details
      flash[:alert] = "製作ステータスの更新に失敗しました"
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def update_order_status(order)
    if order.order_details.any? { |detail| detail.making_status == "manufacturing" }
      order.update(status: "making")
    elsif order.order_details.all? { |detail| detail.making_status == "finish" }
      order.update(status: "preparing_ship")
    end
  end
end