class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { minimum: 8 }, presence: true
  validates :password_confirmation, presence: true
  before_create :format_fields

  def format_fields
    self.email.downcase!
    self.email.strip!
  end

  def self.authenticate_with_credentials(email, password)
    email.downcase!
    email.strip!
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
  end
  #test
end
end
