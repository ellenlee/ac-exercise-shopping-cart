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
    @order.init_status

    if @order.save
      current_cart.destroy
      redirect_to order_path(@order), notice: '已結帳！'
      UserMailer.notify_order_create(@order).deliver_now!
    else
      render :new
    end
  end

  def checkout_pay2go
    @order = current_user.orders.find( params[:id] )

    if @order.order_status != 'new_order'
      flash[:alert] = "你已經付過啦"
      redirecto_to order_path(@order)
    else
      render :layout => false
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :payment_method)
  end

end
