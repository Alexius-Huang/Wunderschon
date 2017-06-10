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
      action_success title: @category.title
      redirect_to backend_categories_path
    else
      action_failed
      render :new
    end
  end

  def show
    @products = @category.products
  end

  def edit; end

  def update
    if @category.update(resource_params)
      action_success title: @category.title
      redirect_to backend_category_path(@category)
    else
      action_failed title: @category.title
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:warning] = i18n(:flash, type: :warning, title: @category.title)
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
