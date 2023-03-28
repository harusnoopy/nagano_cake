class OrderDetail < ApplicationRecord

  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shopping_cost, presence: true
  validates :total_payment, presence: true
  validates :payment_method, presence: true

  belongs_to :order
  belongs_to :item
end
