class JsonWebToken

  def self.encode(payload, exp)
    payload.merge!(exp: (Time.zone.now.to_i + exp))
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)
    HashWithIndifferentAccess.new(decoded_token[0])
  end

end