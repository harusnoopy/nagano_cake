class Public::HomesController < ApplicationController
  before_action :set_item, only: [:top]
  
  def top
    @items = Item.all
    @items_latest4 = @new_items.first(4)
  end

  def about
  end
  
  private
  
  def set_item
    @new_items = Item.order('created_at DESC')
  end
  
end
