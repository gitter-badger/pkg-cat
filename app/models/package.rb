class Package < ActiveRecord::Base
  validates :email, presence: true
  has_many :attachments

  def add(email_attachments)
    email_attachments.each do |email_attachment|
      attachments.create(file: email_attachment)
    end
  end
end
