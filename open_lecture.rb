#!/bin/ruby

require_relative './common/courses.rb'
require_relative './common/rofi.rb'

courses = Courses.new(File.join(__dir__, './info.yaml'))

courses_rofi = courses.for_rofi(true)
courses_rofi = courses_rofi.select {|item| not item.data.lectures.empty?}

out = Rofi.new("Select course:", courses_rofi).show()

if out.nil?
  exit! 1
end

selected_course = out.data

if selected_course.docs.empty?
  exit! 1
end

lectures_rofi = selected_course.lectures.map {
  |lecture| RofiData.new(lecture.name, lecture)
}

out = Rofi.new("Select lecture:", lectures_rofi).show()

if out.nil?
  exit! 1
end

selected_lecture = out.data
selected_lecture.open
