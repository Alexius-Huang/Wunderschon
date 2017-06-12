# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include I18nHelper
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_params_to_model

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_params_to_model
    ApplicationRecord.params = params
  end

  def action_success(**params)
    params[:type] = :success
    flash[:success] = i18n(:flash, params)
  end

  def action_failed(**params)
    params[:type] = :error
    flash[:error] = i18n(:flash, params)
  end
end
