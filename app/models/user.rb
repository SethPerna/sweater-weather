class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
            :presence => {message: "can't be blank"},
            :uniqueness => true

end
