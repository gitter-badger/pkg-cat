class EmailAdapter
  def initialize(email)
    @data = { email: email.from[:email], subject: email.subject }
    @links = {}
  end

  attr_reader :data, :links

  def []=(key, value)
    clean_key = key.strip.downcase.to_sym
    clean_value = value.strip

    if clean_key == :link
      name, url = clean_value.strip.split("|")
      @links[name.strip] = url.strip
    else
      @data[clean_key] = clean_value
    end
  end
end
