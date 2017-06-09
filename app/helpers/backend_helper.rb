# frozen_string_literal: true
module BackendHelper
  def breadcrumb(i18n_prefix = 'dashboard.breadcrumb.', fullpath = request.fullpath)
    path_arr = fullpath.split '/'
    path_arr.shift if path_arr.first.empty?
    path_arr.map.with_index do |path_segment, index|
      if ['new', 'edit'].include? path_segment
        previous_path_segment = path_arr[index - 1]
        t(i18n_prefix + path_segment, target: t(i18n_prefix + previous_path_segment))
      elsif not path_segment.to_i.zero?
        ''
      else
        t(i18n_prefix + path_segment)
      end
    end.reject(&:empty?).join(' >> ')
  end
end
