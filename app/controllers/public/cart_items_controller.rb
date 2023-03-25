class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @cart_items.customer_id = current_customer.id
    @cart_item = CartItem.find(params[:id])
  end

  def update
    @cart_item.customer_id = current_customer.id
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
  end

  def destroy_all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
