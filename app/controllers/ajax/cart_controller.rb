# frozen_string_literal: true
class Ajax::CartController < AjaxController
  before_action :find_product, :find_cart, except: %i[info]
  after_action  :set_cart!, except: %i[info]

  def add_product
    @current_cart.add_item(@product, params[:quantity] || 1)
    respond_to do |format|
      format.json { render json: status(:ok) }
    end
  end

  def delete_product
    @current_cart.delete_item(@product, params[:quantity] || 1)
    respond_to do |format|
      format.json { render json: status(:ok) }
    end
  end

  def info
    respond_to do |format|
      format.json { render json: current_cart.info }
    end
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end

  def status(status_code)
    case status_code
    when :ok then { status: 200 }
    end
  end

  def find_cart
    @current_cart = current_cart
  end

  def set_cart!
    session[:cart] = @current_cart.to_hash
  end
end
