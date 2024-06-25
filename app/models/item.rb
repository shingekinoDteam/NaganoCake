class Item < ApplicationRecord
  has_one_attached :image

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  # validates :is_active, inclusion: { in: is_actives.keys }
  
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre
  
  def with_tax_price
    (self.price * 1.1).floor
  end
end
