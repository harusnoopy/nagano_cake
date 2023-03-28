class CartItem < ApplicationRecord

  validates :item_id, presence: true
  validates :amount, presence: true

  def subtotal
    (item.price * amount * 1.10).floor
  end

  belongs_to :customer
  belongs_to :item
end
