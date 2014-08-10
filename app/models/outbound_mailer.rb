class OutboundMailer < ActionMailer::Base
  default from: "info@gmayorga.bymail.in"

  def confirmation(package)
    @package = package
    @links = package.links
    add_attachments_to_email

    mail(
      to: @package.email,
      subject: "[PKG.CAT CONFIRMATION] " + @package.subject
    )
  end

  def package_request(email)
    @package = Package.find(email.to.first[:token])
    @links = package.links
    @email = email
    add_attachments_to_email

    mail(
      to: email.from[:email],
      subject: @package.subject + " " + @email.subject
    )
  end

  private

  def generate_links(package)
    LinkGenerator.new(package).generate
  end

  def add_attachments_to_email
    @package.attachments.each do |attachment|
      attachments[attachment.file_file_name.to_s] = File.read(attachment.file.path.to_s)
    end
  end
end
