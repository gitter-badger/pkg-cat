class NewPackageMailer < ActionMailer::Base
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

  private

  def add_attachments_to_email
    @package.attachments.each do |attachment|
      attachments[attachment.file_file_name.to_s] = open(attachment.file.url).read
    end
  end
end
