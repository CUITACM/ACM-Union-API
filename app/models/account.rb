class Account < ApplicationRecord
  belongs_to :user

  validates :nickname, :oj_name, :user_id, presence: true, on: [:create]

  # constants
  STATUS_NOT_INIT       = 0
  STATUS_NORMAL         = 1
  STATUS_QUEUE          = 2
  STATUS_UPDATING       = 3
  STATUS_UPDATE_ERROR   = 4
  STATUS_ACCOUNT_ERROR  = 5
  STATUS_STOP           = 100

  OJ_DICT = {
    HDU: 'hdu',
    BNU: 'bnu',
    POJ: 'poj',
    Vjudge: 'vj',
    Codeforces: 'cf',
    Bestcoder: 'bc'
  }

  before_create do
    self.solved = self.submitted = 0
    self.status = STATUS_NOT_INIT
  end

  def password=(pwd)
    self.password_digest = Account.encrypt_password(pwd)
  end

  class << self
    def encrypt_password(pwd)
      Base64.strict_encode64(pwd)
    end

    def decrypt_password(pwd)
      Base64.strict_decode64(pwd)
    end
  end

end
