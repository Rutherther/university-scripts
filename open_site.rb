#!/bin/ruby

require_relative './common/courses.rb'
require_relative './common/rofi.rb'

courses = Courses.new(File.join(__dir__, './info.yaml'))

out = Rofi.new("Select course:", courses.for_rofi(true)).show()

if out.nil?
  exit! 1
end

selected_course = out.data
selected_course.open_url
