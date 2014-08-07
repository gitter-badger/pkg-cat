class OutboundMailer < ActionMailer::Base
  default from: "info@gmayorga.bymail.in"

  def confirmation(package)
    @package = package
    @links = generate_links(package)
    add_attachments_to_email

    mail(to: @package.email,
         subject: "[PKG.CAT CONFIRMATION] #{@package.subject}")
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
