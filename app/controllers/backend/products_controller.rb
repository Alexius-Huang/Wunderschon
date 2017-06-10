# frozen_string_literal: true
class Backend::ProductsController < BackendController
  before_action :find_product, only: %i(show edit update destroy)
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

  def show; end

  def edit; end

  def update
    if @product.update(resource_params)
      redirect_to backend_product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to backend_products_path
  end

  private

  def resource_params
    params.require(:product).permit(:title, :category_id, :description, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
