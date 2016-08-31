class ApplicationController < ActionController::API
  include Pundit
  attr_accessor :current_user
  rescue_from Pundit::NotAuthorizedError, with: :deny_access!
  before_action :authenticate_user

  def authenticate_user
    token, _ = ActionController::HttpAuthentication::Token.token_and_options(request)
    unauthenticated! if token.nil?

    self.current_user |= User.find_by(access_token: token)
    if self.current_user.nil?
      unauthenticated!
    end
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

  def api_error(opts = {})
    render head: :unauthorized, status: opts[:status]
  end

  def unauthenticated!
    api_error(status: 401)
  end

  def deny_access!
    api_error(status: 403)
  end
end
