class DataTypeIdentifier
  def initialize(email)
    @data = {
      email: email.from[:email],
      subject: email.subject,
      private_token: SecureRandom.urlsafe_base64(64)
    }
    @links = {}
  end

  attr_reader :data, :links

  def identify(key, value)
    clean_key = key.strip.downcase.to_sym
    clean_value = value.strip

    if clean_key == :link
      name, url = clean_value.strip.split("|")
      @links[name.strip] = url.strip
    elsif clean_key == :slug
      @data[:slug] = clean_value.parameterize
    elsif
      @data[clean_key] = clean_value
    end
  end
end
