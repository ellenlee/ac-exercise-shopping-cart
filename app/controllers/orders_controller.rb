class OrdersController < ApplicationController
  before_action :authenticate_user!
  # Visitor 在這裡第一次登入，成為 Customer

  def new
    @order = current_user.orders.build(email: current_user.email)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.add_order_items(current_cart)
    @order.amount = current_cart.total

    if @order.save
      current_cart.destroy
      redirect_to order_path(@order), notice: '已結帳！'
    else
      render :new
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :payment_method)
  end

end
