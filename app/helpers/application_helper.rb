# frozen_string_literal: true
module ApplicationHelper
  def fake_image(width = 500, height = 500, color = 'dddddd', text = 'Hello')
    "http://fakeimg.pl/#{width}x#{height}/#{color}/?text=#{text}"
  end
end
