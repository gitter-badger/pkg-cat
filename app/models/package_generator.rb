class PackageGenerator
  def initialize(email)
    @email = email
    @email_adapter = EmailAdapter.new(email)
  end

  def generate
    Package.create(@email_adapter.data).tap do |package|
      package.update_links(@email_adapter.links)
      package.update_attachments(@email.attachments)
    end
  end
end
