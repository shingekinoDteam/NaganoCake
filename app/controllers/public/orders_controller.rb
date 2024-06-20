class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def create
  @order = Order.new(order_params)

    if @order.save

      @cart_items = current_customer.cart_items.all

      @cart_items.each do |cart_item|
        @order_details = OrderDetail.new
        @order_details.order_id = @order.id
        @order_details.item_id = cart_item.item.id
        @order_details.price = cart_item.item.with_tax_price
        @order_details.amount = cart_item.amount
        @order_details.making_status = 0
        @order_details.save!
      end
      flash[:notice] = "注文が成功しました"

      CartItem.destroy_all
      redirect_to orders_thanks_path
    else
      flash.now[:alert] = "注文に失敗しました"
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @addresses = current_customer.addresses.all

     if params[:order][:address_option] == "0"
       @order.postal_code = current_customer.postal_code
       @order.name = current_customer.first_name + current_customer.last_name
       @order.address = current_customer.address

     elsif params[:order][:address_option] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name

     elsif params[:order][:address_option] == "2"
       @order.customer_id = current_customer.id
     end
       @cart_items = current_customer.cart_items
       @order_new = Order.new
       render :confirm
  end

  def thanks
  end


  def index
     @orders = Order.all
  end

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method,:shipping_cost,:total_payment,:status,:customer_id)
  end
end
