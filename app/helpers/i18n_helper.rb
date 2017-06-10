# frozen_string_literal: true
module I18nHelper
  def i18n(type, params)
    case type
    when :enum   then t("activerecord.attributes.#{params[:model]}.statuses.#{params[:status]}")
    when :column then t("activerecord.attributes.#{params[:model]}.#{params[:name]}")
    else
      "Missing translation for i18n helper type '#{type}' with value '#{params}'"
    end
  end
end
