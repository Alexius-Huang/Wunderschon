# frozen_string_literal: true
class BackendController < ApplicationController
  before_action :without_navbar
  before_action :backend_mode

  def main; end

  private

  def without_navbar
    @without_navbar = true
  end

  def backend_mode
    @backend = true
  end
end
