require 'open3'

class RofiData
  def initialize(name, data)
    @name = name
    @data = data
  end

  def data()
    @data
  end

  def to_s()
    @name
  end
end

class Rofi
  def initialize(title, data)
    @cmd = "rofi -dmenu -markup-rows -i"
    @title = title
    @data = data
  end

  def show()
    @out = Open3.capture2(
      @cmd + ' -p ' + @title + '',
      :stdin_data=>rofi_data
    )[0].strip!

    if @data.kind_of?(Array)
      @out = @data.find {|item| item.to_s.eql? @out}
    end

    @out
  end

  def data()
    @out
  end

  private

  def rofi_data()
    data = @data
    if data.kind_of?(Array)
      data = data.map {|item| item.to_s}.join("\n")
    end

    data
  end
end
