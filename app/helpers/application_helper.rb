# frozen_string_literal: true
module ApplicationHelper
  def fake_image(width = 500, height = 500, color = 'dddddd', text = 'Hello')
    "http://fakeimg.pl/#{width}x#{height}/#{color}/?text=#{text}"
  end

  def fa_icon(icon, additional_class = [])
    content_tag :span, '' , class: ['fa', "fa-#{icon}"].concat(additional_class)
  end
end
