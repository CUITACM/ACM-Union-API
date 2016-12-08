class ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :api_error!

  protected

  def current_user
    auth_header = request.headers['Authorization']
    payload = auth_header && JsonWebToken.decode(auth_header.split(' ').last)
    token = payload && payload[:user_id]
    api_error! and return if token.blank?
    User.find_by(id: token)
  end

  def authenticate_user
    begin
      api_error! if current_user.blank?
    rescue JWT::VerificationError, JWT::DecodeError
      api_error!(message: '授权失败')
    rescue JWT::ExpiredSignature
      api_error!(message: '授权已过期')
    end
  end

  def api_error!(**things)
    info = { error: 1 }.merge(things)
    render status: :unauthorized, json: info
  end

  def deny_access!(**things)
    info = { error: 1 }.merge(things)
    render status: :forbidden, json: info
  end

  def meta_with_page(resource, extra_meta = {})
    {
        current_page: resource.current_page,
        next_page: resource.next_page,
        prev_page: resource.prev_page,
        total_pages: resource.total_pages,
        total_count: resource.total_count
    }.merge(extra_meta)
  end

end
