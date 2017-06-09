# frozen_string_literal: true
class Backend::CategoriesController < BackendController
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

  private

  def resource_params
    params.require(:category).permit(:title, :description)
  end
end
