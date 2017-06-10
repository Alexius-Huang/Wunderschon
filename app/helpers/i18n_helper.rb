# frozen_string_literal: true
module I18nHelper
  def i18n(type, params)
    case type
    when :enum   then t("activerecord.attributes.#{params[:model]}.statuses.#{params[:status]}")
    when :column then t("activerecord.attributes.#{params[:model]}.#{params[:name]}")
    when :flash  then get_flash_message(params)
    else
      "Missing translation for i18n helper type '#{type}' with value '#{params}'"
    end
  end

  def get_flash_message(params)
    if self.class.parent == Backend
      t("flash_message.#{params[:type]}.backend.#{controller_name}.#{action_name}", title: (params.key?(:title) ? params[:title] : nil))
    else
      t("flash_message.#{params[:type]}.#{controller_name}.#{action_name}", title: (params.key?(:title) ? params[:title] : nil))
    end
  end
end
