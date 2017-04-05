class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
  before_action :authenticate_admin # 再檢查是否有權限
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.page(params[:page]).per(50)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: 'product was successfully created'
    else
      render new_admin_product_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'update successfully'
    else
      render action: :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, alert: 'product deleted.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :image_url, :description, :in_stock_qty)
  end

end
