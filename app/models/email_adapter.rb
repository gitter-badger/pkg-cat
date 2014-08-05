class EmailAdapter
  def initialize(email)
    @data = { email: email.from[:email], subject: email.subject, links: [] }
  end

  attr_reader :data

  def []=(key, value)
    clean_key = key.strip.downcase.to_sym
    clean_value = value.strip

    if clean_key == :link
      @data[:links] << clean_value
    else
      @data[clean_key] = clean_value
    end
  end
end
