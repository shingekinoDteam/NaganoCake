class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end
  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)

    if @order.save
       cart_items.each do |cart|
          order_detail = OrderItem.new
          order_detail.item_id = cart.item_id
          order_detail.order_id = @order.id
          order_detail.amount = cart.amount

          order_detail.price = cart.item.price
          order_item.save
       end
       redirect_to orders_thanks_path
       cart_items.destroy_all
    else
       @order = Order.new(order_params)
       render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
     if params[:order][:address_option] == "0"
       @order.name = current_customer.name
       @order.address = current_customer.customer_address
     elsif params[:order][:address_option] == "1"
       if Address.exists?(name: params[:order][:registered])
           @order.name = Address.find(params[:order][:registered]).name
           @order.address = Address.find(params[:order][:registered]).address
       else
       render :new
       end
     elsif params[:order][:address_option] == "2" 
       address_new = current_customer.addresses.new(address_params)
       if address_new.save
       else
         render :new
  　    end
  　 end
  　 #cart-itemモデルで定義def sum_price item.taxin_price*quantity end
  　 #@cart_items = current_customer.cart_items.all 
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end
  
  def thanks
  end


  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method,:shipping_cost,:total_payment,:status,:customer_id)
  end

  def address_params
  params.require(:order).permit(:name, :address, :postal_code)
  end
end
