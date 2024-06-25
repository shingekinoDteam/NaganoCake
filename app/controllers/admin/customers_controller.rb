class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.page(params[:page]).per(15)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(params[:id]), notice: "編集内容を保存しました"
    else
      render 'edit'
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :last_name_kana, :first_name, :first_name_kana, :postal_code, :address,:telephone_number, :email, :is_active)
  end
end
