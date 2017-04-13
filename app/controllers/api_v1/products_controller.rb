class ApiV1::ProductsController < ApiController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by(id: params[:id])
    if !@product
      render json: { message: "Can't find the product!!"}, status: 400
    end
  end
end