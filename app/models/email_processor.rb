class EmailProcessor
  def initialize(inbound_email)
    @inbound_email = inbound_email
  end

  def process
    if mail_to_new?
      generate_package
    else
      process_package_request
    end
  end

  private

  def mail_to_new?
    @inbound_email.to.first[:token].parameterize == "new"
  end

  def generate_package
    package = PackageGenerator.new(@inbound_email).generate
    deliver_confirmation(package)
  end

  def deliver_confirmation(package)
    NewPackageMailer.confirmation(package).deliver
  end

  def process_package_request
    deliver_package_request(@inbound_email)
  end

  def deliver_package_request(recipient, package)
    RequestPackageMailer.package_request(email).deliver
  end
end
