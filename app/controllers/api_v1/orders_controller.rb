class ApiV1::OrdersController < ApiController
  before_action :authenticate_user

  def index
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = @user.orders.new(order_params)
    @order.add_line_items(current_cart)
    @order.init_status

    if @order.save
      redirect_to v1_order_path(@order)
    else
      render json: { message: "can't save!" }
    end


  end

  protected

  def authenticate_user
    if params[:auth_token].present?
      @user = User.find_by(authentication_token: params[:auth_token])
    else
      render json: { errors: "cannot find authentication token." }
    end
  end

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address, :payment_method)
  end
end