class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    if mail_to_new?
      generate_package
    else
      deliver_requested_package
    end
  end

  private

  def mail_to_new?
    @email.to.first[:token].parameterize == "new"
  end

  def generate_package
    package = PackageGenerator.new(@email).generate
    deliver_confirmation(package)
  end

  def deliver_confirmation(package)
    OutboundMailer.confirmation(package).deliver
  end

  def deliver_requested_package
    OutboundMailer.package_request(@email).deliver
  end
end
