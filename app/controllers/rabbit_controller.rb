# frozen_string_literal: true
class RabbitController < ApplicationController
  before_action :without_navbar

  def index; end

  private

  def without_navbar
    @without_navbar = true
  end
end
