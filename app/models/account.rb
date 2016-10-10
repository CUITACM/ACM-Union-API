class Account < ApplicationRecord

  def set_password(pwd)
    self.password_digest = Account.encrypt_password(pwd)
  end

  def self.encrypt_password(pwd)
    ActiveSupport::Base64.encode64(pwd)
  end

  def self.decrypt_password(pwd)
    ActiveSupport::Base64.decode64(pwd)
  end

end
