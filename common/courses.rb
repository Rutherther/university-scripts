require 'yaml'
require_relative 'course.rb'

class Courses 
  def initialize(config_path)
    config = YAML.load_file(config_path)

    @config = config
    @root_path = config["root_path"]
    @courses_path = config["courses_path"]
    @current_semester = config["current_semester"]
    @current_course = nil
  end

  def get_courses()
    courses = []

    Dir.entries(courses_path).each do |file|
      file = File.join(courses_path, file)

      if File.directory? file and Course.course_directory? file
        courses.append(Course.new(@config, file))
      end
    end

    return courses
  end

  def for_rofi(current)
    courses = get_courses

    if current
      current = current_course

      if not current.nil?
        courses.prepend(current)
      else
        puts "rip"
      end
    end

    courses.map {
      |course| RofiData.new('<b>' + course.abbreviation + ': </b> ' + course.display_name, course)
    }
  end

  def root_path()
    @root_path
  end

  def courses_path()
    File.join(@root_path, @courses_path)
  end

  def current_course()
    if @current_course.nil? and Course.course_directory? File.join(@root_path, 'current_course')
      @current_course = Course.new(@config, File.join(@root_path, 'current_course'), true)
    end

    @current_course
  end

  def current_course=(course)
    @current_course = course
    path = File.join(@root_path, 'current_course')
    if File.exists? path
      File.unlink(path)
    end

    File.symlink(course.path, path)
  end
end
