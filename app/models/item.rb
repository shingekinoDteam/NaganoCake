class Item < ApplicationRecord
  has_one_attached :image
  enum status: { on_sale: 0, off_sale: 1 }

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre
end
