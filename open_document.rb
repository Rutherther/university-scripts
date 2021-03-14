#!/bin/ruby

require_relative './common/courses.rb'
require_relative './common/rofi.rb'

courses = Courses.new(File.join(__dir__, './info.yaml'))

courses_rofi = courses.for_rofi(true)
courses_rofi = courses_rofi.select {|item| not item.data.docs.empty?}

out = Rofi.new("Select course:", courses_rofi).show()

if out.nil?
  exit! 1
end

selected_course = out.data

if selected_course.docs.empty?
  exit! 1
end

documents_rofi = selected_course.docs.map {
  |document| RofiData.new(document.name, document)
}

out = Rofi.new("Select document:", documents_rofi).show()

if out.nil?
  exit! 1
end

selected_document = out.data
selected_document.open
