# frozen_string_literal: true
class Backend::CategoriesController < BackendController
  before_action :find_category, only: %i(show edit update destroy)

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(resource_params)
    if @category.save
      redirect_to backend_categories_path
    else
      render :new
    end
  end

  def show
    @products = @category.products
  end

  def edit; end

  def update
    if @category.update(resource_params)
      redirect_to backend_category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to backend_categories_path
  end

  private

  def resource_params
    params.require(:category).permit(:title, :description)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
