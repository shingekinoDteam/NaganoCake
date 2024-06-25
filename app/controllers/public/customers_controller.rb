class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
  end

  def edit
  end

  def update
    customer = current_customer
    if customer.update(customer_params)
      redirect_to customers_my_page_path, notice: "保存しました"
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    customer = current_customer
    customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :telephone_number, :address)
  end
end
