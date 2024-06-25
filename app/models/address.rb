class Address < ApplicationRecord

  belongs_to :customer

  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true, length: { maximum: 100 }
  validates :name, presence: true, length: { maximum: 30 }
end
