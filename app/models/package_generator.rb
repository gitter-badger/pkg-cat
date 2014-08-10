class PackageGenerator
  def initialize(email)
    @email = email
    @email_adapter = EmailAdapter.new(email)
  end

  def generate
    adapt_email

    Package.create(@email_adapter.data).tap do |package|
      package.update_links(@email_adapter.links)
      package.update_attachments(@email.attachments)
    end
  end

  private

  def adapt_email
    email_body_lines.each do |line|
      key, value = clean(line)
      @email_adapter[key] = value
    end
  end

  def email_body_lines
    email_body.split("\n\n").reject(&:empty?)
  end

  def email_body
    @email.body
  end

  def clean(line)
    line.strip.split(">")
  end
end
