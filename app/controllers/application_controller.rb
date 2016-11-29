class ApplicationController < ActionController::API
  include Pundit
  attr_accessor :current_user
  rescue_from Pundit::NotAuthorizedError, with: :api_error!
  before_action :authenticate_user

  protected

  def authenticate_user
    token = auth_token
    api_error! and return if token.blank?
    @current_user = User.find_by(id: token)
    api_error! if @current_user.blank?
  rescue JWT::VerificationError, JWT::DecodeError
    api_error!(message: '验证失败')
  rescue JWT::ExpiredSignature
    api_error!(message: '授权已过期')
  end

  def api_error!(things = {})
    things.merge!(error: 1)
    render status: :unauthorized, json: things
  end

  def auth_token
    auth_header = request.headers['Authorization']
    http_token = auth_header.split(' ').last if auth_header.present?
    payload = http_token && JsonWebToken.decode(http_token)
    payload && payload[:user_id]
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
