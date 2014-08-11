class EmailAdapter
  def initialize(email)
    @email = email
    @data = { email: email.from[:email], subject: email.subject }
    @links = {}
    process_email_body
  end

  attr_reader :data, :links

  def process_email_body
    @email.body_lines.each do |line|
      key, value = line.strip.split(">")
      add_to_data_or_links(key, value)
    end
  end

  def add_to_data_or_links(key, value)
    clean_key = key.strip.downcase.to_sym
    clean_value = value.strip

    if clean_key == :link
      name, url = clean_value.strip.split("|")
      @links[name.strip] = url.strip
    else
      @data[clean_key] = clean_value
    end
  end

  private

  def email_body_lines
    @email.body.split("\n\n").reject(&:empty?)
  end
end
