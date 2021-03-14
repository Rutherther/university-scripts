class Document
  def initialize(courses_config, name, path)
    @courses_config = courses_config
    @name = name
    @path = path
  end

  def path()
    @path
  end

  def name()
    @name
  end

  def open()
    fork { exec(@courses_config["pdf_browser"] + " " + @path) }
  end
end


class Documents
  def initialize(path, courses_config, documents)
    @documents = []

    if documents.nil?
      return
    end

    documents.each do |document|
      @documents.append(Document.new(
        courses_config,
        document["name"],
        File.join(path, document["path"])
      ))
    end
  end

  def empty?()
    @documents.empty?
  end

  def map(&block)
    @documents.map(&block)
  end

  def each(&block)
    @documents.each(&block)
  end

  def documents()
    @documents
  end
end
