require_relative 'documents.rb'
require_relative 'lectures.rb'

class Course
  def initialize(courses_config, path, current = false)
    @path = path
    @courses_config = courses_config

    config_path = File.join(path, 'info.yaml')
    config = YAML.load_file(config_path)

    @name = config["name"]
    @display_name = current ? "Current course" : @name
    @abbreviation = config["abbr"]
    @url = config["url"]
    @docs = Documents.new(@path, @courses_config, config["docs"])
    @lectures = Lectures.new(@courses_config, config["lectures"])

    @lecture = config["lecture"]
    @homework = config["homework"]
    @practice = config["practice"]
  end

  def self.course_directory?(directory)
    return !(Dir[File.join(directory, "info.yaml")].empty?)
  end

  def open_folder()
    fork {
      exec(@courses_config["folder_browser"] + " " + @path)
    }
  end

  def open_folder_terminal()
    fork {
      exec(@courses_config["terminal"] + " " + @path)
    }
  end

  def open_url()
    fork {
      exec (@courses_config["web_browser"] + " " + @url)
    }
  end

  def path()
    @path
  end

  def display_name()
    @display_name
  end

  def name()
    @name
  end

  def abbreviation()
    @abbreviation
  end

  def url()
    @url
  end

  def docs()
    @docs
  end

  def lectures()
    @lectures
  end

  def lecture()
    @lecture
  end

  def homework()
    @homework
  end

  def practice()
    @practice
  end
end
