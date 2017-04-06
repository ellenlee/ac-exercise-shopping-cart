class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update]


  def index
    @orders = Order.all
  end

  def update
    @order.update(order_params)

    redirect_to admin_orders_path, notice: 'Date update.'
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :amount, :payment_method, :payment_status, :order_status)
  end

end
