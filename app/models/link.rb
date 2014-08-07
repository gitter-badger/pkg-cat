class Link
  def initialize(data)
    @data = data
    process
  end

  attr_reader :name, :url

  def to_partial_path
    "links/link"
  end

  private

  def process
    name, url = @data.strip.split("|")
    @name = name.strip
    @url = url.strip
  end
end
