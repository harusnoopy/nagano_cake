class OrderDetail < ApplicationRecord

  validates :item_id, presence: true
  validates :order_id, presence: true
  validates :price, presence: true
  validates :amount, presence: true

  def subtotal
    (item.price * amount * 1.10).floor.to_i.to_s(:delimited)
  end

  belongs_to :order
  belongs_to :item
end
