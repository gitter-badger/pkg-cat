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

  before_create :verify_unique_slug

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

  def to_param
    token
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

  def slug=(proposed_slug)
    if slug != proposed_slug && Package.exists?(slug: proposed_slug)
      self[:slug] = slug
    elsif proposed_slug.empty?
      self[:slug] = SecureRandom.hex(3)
    else
      self[:slug] = proposed_slug.parameterize
    end
  end

  private

  def verify_unique_slug
    if slug.blank? || Package.exists?(slug: slug)
      self.slug = SecureRandom.hex(3)
    end
  end
end
