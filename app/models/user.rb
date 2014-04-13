class User < ActiveRecord::Base
  validates :email, presence: true

  before_validation { self.email = email.downcase }
end
