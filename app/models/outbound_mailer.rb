class OutboundMailer < ActionMailer::Base
  def confirmation(package)
    @package = package
    @links = package.links
    add_attachments_to_email

    mail(
      to: @package.email,
      from: "new@pkg.cat",
      subject: "[PKG.CAT CONFIRMATION] " + @package.subject
    )
  end

  def package_request(email)
    @package = Package.find_by!(slug: email.to.first[:token].parameterize)
    @links = @package.links
    @email = email
    add_attachments_to_email

    mail(
      to: email.from[:email],
      from: email.to.first[:email],
      subject: @package.subject + " " + @email.subject
    )
  end

  private

  def add_attachments_to_email
    @package.attachments.each do |attachment|
      attachments[attachment.file_file_name.to_s] = open(attachment.file.url).read
    end
  end
end
