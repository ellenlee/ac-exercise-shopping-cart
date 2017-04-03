class OrdersController < ApplicationController
  before_action :authenticate_user!
  # Visitor 在這裡第一次登入，成為 Customer
  before_action :set_order, only: [:show, :update]

  def index
    @orders = current_user.orders
  end

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

  def update
    if order.order_status != "shipped"
      order.update!( order_status: 'cancelled')
      flash[:alert] = "訂單已取消"
    end

    redirect_to orders_path
  end

  protected

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :payment_method)
  end

end
