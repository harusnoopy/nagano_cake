class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:pa])
  end

  def show
  end

  def edit
  end

  def update
  end
end
