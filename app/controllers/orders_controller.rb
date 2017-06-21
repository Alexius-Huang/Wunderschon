# frozen_string_literal: true
class OrdersController < ApplicationController
  def index; end

  # Action .checkout
  def new
    @order = Order.new
  end

  def create; end

  def show; end

  def edit; end

  def update; end

  def destroy; end
end
