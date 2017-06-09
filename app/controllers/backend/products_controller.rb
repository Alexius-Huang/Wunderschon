# frozen_string_literal: true
class Backend::ProductsController < BackendController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(resource_params)
    if @product.save
      redirect_to backend_products_path
    else
      render :new
    end
  end

  private

  def resource_params
    params.require(:product).permit(:title, :category_id, :description, :price)
  end
end
