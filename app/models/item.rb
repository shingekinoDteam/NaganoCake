class Item < ApplicationRecord
  has_one_attached :image
  enum status: { on_sale: 0, off_sale: 1 }

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  # validates :is_active, inclusion: { in: is_actives.keys }
  validates :genre, presence: true
  
  def with_tax_price
    (self.price * 1.1).floor
  end
end
