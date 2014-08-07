class LinkGenerator
  def initialize(package)
    @package = package
  end

  def generate
    @package.links.map do |name_and_url|
      Link.new(name_and_url)
    end
  end
end
