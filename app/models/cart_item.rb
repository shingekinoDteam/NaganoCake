class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def quantity
    read_attribute(:quantity) || 0
  end
end
