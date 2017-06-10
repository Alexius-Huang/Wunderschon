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
      action_success title: @product.title
      redirect_to backend_products_path
    else
      action_failed
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update(resource_params)
      action_success title: @product.title
      redirect_to backend_product_path(@product)
    else
      action_failed title: @product.title
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:warning] = i18n(:flash, type: :warning, title: @product.title)
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
