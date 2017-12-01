class User < ActiveRecord::Base
  has_many :notes
  require 'bcrypt'
  require 'securerandom'

  def generate_n_set_encrypted_password password_string
    self.encrypted_password = BCrypt::Password.create (password_string).to_s
  end

  def password_matches?(password_string)
    # NOTE: in programming, x == y may not yield the same result as y == x
    BCrypt::Password.new(self.encrypted_password) == password_string
  end

  def generate_n_set_activation_code
    # SecureRandom.urlsafe_base64(n) method generates a random number of n bytes
    # length of generated string is about (4/3)*n
    self.activation_code = SecureRandom.urlsafe_base64 13
  end

  def set_status bool_val
    self.active = bool_val
  end
end
