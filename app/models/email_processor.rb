class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    if mail_to_new?
      generate_package
    end
  end

  private

  def mail_to_new?
    @email.to.first[:token] == "new"
  end

  def generate_package
    package = PackageGenerator.new(@email).generate
    package.save
    package.add(@email.attachments)
    deliver_confirmation(package)
  end

  def deliver_confirmation(package)
    OutboundMailer.confirmation(package).deliver
  end
end
