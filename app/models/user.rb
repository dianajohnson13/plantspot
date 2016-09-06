class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :microposts

  before_save {self.email = email.downcase}
  
  validates(:username,
            presence: true,
            length: {maximum: 50},
            uniqueness: true)
  
  validates(:email, presence: true,
            length: {maximum: 255},
            uniqueness: {case_sensitive: false})

  has_secure_password
  validates(:password, presence: true, length: {minimum: 6}, allow_nil: true)

  validates(:mini_bio, length: {maximum: 255})

  def feed
    Micropost.where("user_id = ?", id)
  end

  # Returns a password_digest for the passed in string
  # Used for the user fixture in the login integeration tests
  def User.digest(string)
    BCrypt::Password.create(string)
  end

  # store user's (encrypted) id and token as permanent cookies in the browzer to create a persistent session
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # checks whether the passed in token matches the saved
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

end
