class EmailAdapter
  def initialize(email)
    @email = email
    @data_type_identifier = DataTypeIdentifier.new(email)
    @sanitized_data = process_email_body
  end

  def data
    @sanitized_data
  end

  def links
    @data_type_identifier.links
  end

  private

  def process_email_body
    email_body_lines.each do |line|
      key, value = line.strip.split(">")
      @data_type_identifier.identify(key, value)
    end

    DataSanitizer.new(@data_type_identifier.data).sanitized_data
  end

  def email_body_lines
    @email.body.split("\n\n").reject(&:empty?)
  end
end
