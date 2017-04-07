class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 注意這裡的位置是 Application Controller，由於 Cookie - Session 和瀏覽器有關，我們必須將這個方法放在 controller 裡（而非移到 model）
  # 另外，在 View 裡呼叫 Controller 方法時，必須使用 helper_method

  helper_method :current_cart

  protected

  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

  def current_cart
    @cart || set_cart # 如果 @cart 存在就回傳 @cart，否則呼叫 set_cart 方法
  end

  def set_cart
    # 根據 session 來搜尋特定 Cart
    if session[:cart_id]
      @cart = Cart.find_by(id: session[:cart_id])
    end

    @cart ||= Cart.create
    # 若 session[:cart_id] 存在，此時 @cart 會回傳 True；然而，若 session[:cart_id] 不存在，此時 @cart = nil，那麼就執行 Cart.create 並寫入 @cart
    # 注意我們不使用 if..else.. 因為我們希望無論遇到任何情況，只要 @cart = nil，在這裡我們都能獲取一個 @cart

    session[:cart_id] = @cart.id
    @cart
  end

end