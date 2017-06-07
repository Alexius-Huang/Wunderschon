# frozen_string_literal: true
class CategoriesController < ApplicationController
  before_action :find_category, only: %i[show]

  def main; end

  def show; end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
