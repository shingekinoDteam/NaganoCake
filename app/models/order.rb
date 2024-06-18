class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :name, presence: true, length: { maximum: 30 }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}
end
