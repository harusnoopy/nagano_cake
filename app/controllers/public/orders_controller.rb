class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name 
    elsif params[:order][:select_address] == "1"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render :new
    end
  end

  def create
    order =  Order.new(order_params)
    order.customer_id = current_customer.id
    if order.save!
      current_customer.cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.amount = cart_item.amount
        @order_detail.price = cart_item.item.delimit_add_tax
        @order_detail.save!
      end
      current_customer.cart_items.destroy_all
      redirect_to thanx_path
    else
      render :new
    end
  end

  def thanx
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shopping_cost, :total_payment, :payment_method)
  end
  
end
