class Package < ActiveRecord::Base
  validates :email, presence: true
  has_many :attachments, dependent: :destroy
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links,
    reject_if: lambda { |link| link[:url].blank? },
    allow_destroy: true
  accepts_nested_attributes_for :attachments,
    reject_if: lambda { |attachment| attachment[:file].blank? },
    allow_destroy: true

  def update_attachments(email_attachments)
    email_attachments.each do |email_attachment|
      attachments.create(file: email_attachment)
    end
  end

  def update_links(email_links)
    email_links.each do |name, url|
      links.create(name: name, url: url)
    end
  end

  def attach(file_params)
    if file_params.present?
      attachments.create(file: file_params)
    end
  end

  def twitter?
    twitter.present?
  end

  def github?
    github.present?
  end

  def blog?
    blog.present?
  end
end
