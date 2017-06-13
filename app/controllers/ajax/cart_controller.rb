# frozen_string_literal: true
class Ajax::CartController < AjaxController
  before_action :find_product, :find_cart, except: %i[get_data]
  after_action  :set_cart!, except: %i[get_data]

  def add_product
    @current_cart.add_item(@product, params[:quantity] || 1)
    respond_to do |format|
      format.json { render json: { status: 200 } }
    end
  end

  def delete_product
    @current_cart.delete_item(@product, params[:quantity] || 1)
    respond_to do |format|
      format.json { render json: { status: 200 } }
    end
  end

  def get_data
    respond_to do |format|
      format.json { render json: current_cart.info }
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_cart
    @current_cart = current_cart
  end

  def set_cart!
    session[:cart] = @current_cart.to_hash
  end
end
