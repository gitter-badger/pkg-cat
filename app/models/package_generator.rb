class PackageGenerator
  def initialize(email)
    @email = email
    @email_adapter = EmailAdapter.new(email)
  end

  def generate
    email_body_lines.each do |line|
      key, value = clean(line)
      @email_adapter[key] = value
    end

    Package.new(@email_adapter.data)
  end

  private

  def email_lines
    email_body.split("\n\n").reject(&:empty?)
  end

  def email_body
    @email.body
  end

  def clean(line)
    line.strip.split(">")
  end
end
