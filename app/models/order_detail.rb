class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { impossible_manufacture: 0, waiting_manufacture: 1, manufacturing: 2, finish: 3 }

  after_update :update_order_status

  private

  def update_order_status
    order.update(status: "making") if manufacturing?
    if order.order_details.all? { |detail| detail.finish? }
      order.update(status: "preparing_ship")
    end
  end
end