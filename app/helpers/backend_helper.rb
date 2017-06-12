# frozen_string_literal: true
module BackendHelper
  def breadcrumb(i18n_prefix = 'dashboard.breadcrumb.', fullpath = request.fullpath)
    path_arr = fullpath.split '/'
    path_arr.shift if path_arr.first.empty?
    path_arr.map.with_index do |path_segment, index|
      path_segment = path_segment.match(/[a-z]+/).to_s
      case path_segment
      when 'new'
        previous_path_segment = path_arr[index - 1]
        t(i18n_prefix + path_segment, target: t(i18n_prefix + previous_path_segment))
      when 'edit'
        previous_path_segment = path_arr[index - 2]
        t(i18n_prefix + path_segment, target: t(i18n_prefix + previous_path_segment))
      when 'page' then nil
      when ''     then nil
      else
        t(i18n_prefix + path_segment)
      end
    end.reject(&:nil?).join(' >> ')
  end
end
