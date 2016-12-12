class ApplicationController < ActionController::API
  include Pundit
  attr_reader :current_user
  rescue_from Pundit::NotAuthorizedError, with: :deny_access!

  protected

  def get_current_user
    @current_user if @current_user.present?
    auth_header = request.headers['Authorization']
    payload = auth_header && JsonWebToken.decode(auth_header.split(' ').last)
    token = payload && payload[:user_id]
    return nil if token.blank?
    @current_user = User.find_by(id: token)
  end

  def authenticate_user
    begin
      api_error! if get_current_user.blank?
      Rails.logger.info("App#current_user ==> #{@current_user.id}/#{@current_user.nickname}")
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
