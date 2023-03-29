class Item < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  def delimit_add_tax
    (price * 1.10).floor.to_i.to_s(:delimited)
  end

  def delimit
    price.to_i.to_s(:delimited)
  end

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
end
