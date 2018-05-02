class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { :minimum => 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email,password)
    user = find_by_email(email.strip.downcase)
    user if user && user.authenticate(password)
  end
end
