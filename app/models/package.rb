class Package < ActiveRecord::Base
  validates :email, presence: true
end
