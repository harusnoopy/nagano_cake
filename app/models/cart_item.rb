class CartItem < ApplicationRecord

  def subtotal
    (item.price * amount * 1.10).floor.to_i.to_s(:delimited)
  end

  belongs_to :customer
  belongs_to :item
end
