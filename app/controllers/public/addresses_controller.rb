class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to request.referer, notice: "新規登録しました"
    else
      render 'index'
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "編集内容を保存しました"
    else
      render 'index'
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to request.referer
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
