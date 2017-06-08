# frozen_string_literal: true
module BackendHelper
  def breadcrumb(i18n_prefix = 'dashboard.breadcrumb.', fullpath = request.fullpath)
    path_arr = fullpath.split '/'
    path_arr.shift if path_arr.first.empty?
    path_arr.map { |path_segment| t(i18n_prefix + path_segment) }.join(' >> ')
  end
end
