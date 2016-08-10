class User < ApplicationRecord
  has_many :microposts

  before_save {self.email = email.downcase}
  
  validates(:username, presence: true, length: {maximum: 50})
  
  validates(:email, presence: true, 
            length: {maximum: 255},
            uniqueness: {case_sensitive: false})

  has_secure_password
  validates(:password, presence: true, length: {minimum: 6})

  def feed
    Micropost.where("user_id = ?", id)
  end

  # Returns a password_digest for the passed in string
  # Used for the user fixture in the login integeration tests
  def User.digest(string)
    BCrypt::Password.create(string)
  end
end
