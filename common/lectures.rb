class Lecture
  def initialize(courses_config, name, url)
    @url = url
    @name = name
    @courses_config = courses_config
  end

  def open()
    fork { exec(@courses_config["web_browser"], @url) }
  end

  def name()
    @name
  end

  def url()
    @url
  end
end

class Lectures
  def initialize(courses_config, lectures)
    @lectures = []

    if lectures.nil?
      return
    end

    lectures.each do |lecture|
      @lectures.append(Lecture.new(
        courses_config,
        lecture["name"],
        lecture["url"]
      ))
    end
  end

  def empty?()
    @lectures.empty?
  end

  def each(&block)
    @lectures.each(&block)
  end

  def map(&block)
    @lectures.map(&block)
  end

  def lectures()
    @lectures
  end
end
