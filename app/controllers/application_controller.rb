class ApplicationController < ActionController::API
  include Pundit
  attr_reader :current_user

  # 参数值不在允许的范围内
  # HTTP Status 400 { error: 'ParameterInvalid', message: '原因' }
  class ParameterValueNotAllowed < ActionController::ParameterMissing
    attr_reader :values
    def initialize(param, values) # :nodoc:
      @param = param
      @values = values
      super("param: #{param} value only allowed in: #{values}")
    end
  end

  # 未登录返回信息
  # HTTP Status 401 { error: 'Unauthorized', message: '原因' }
  class Unauthorized < StandardError; end

  # 无权限返回信息
  # HTTP Status 403 { error: 'AccessDenied', message: '原因' }
  class AccessDenied < StandardError; end

  # 数据不存在
  # HTTP Status 404 { error: 'ResourceNotFound', message: '原因' }
  class PageNotFound < StandardError; end

  # error handlers
  rescue_from(Pundit::NotAuthorizedError) do |err|
    render json: { error: 'NotAuthorized', message: err }, status: 403
  end
  rescue_from(ActionController::ParameterMissing) do |err|
    render json: { error: 'ParameterInvalid', message: err }, status: 400
  end
  rescue_from(ActiveRecord::RecordInvalid) do |err|
    render json: { error: 'RecordInvalid', message: err }, status: 400
  end
  rescue_from(AccessDenied) do |err|
    render json: { error: 'AccessDenied', message: err }, status: 403
  end
  rescue_from(ActiveRecord::RecordNotFound) do
    render json: { error: 'ResourceNotFound' }, status: 404
  end

  def requires!(name, opts = {})
    opts[:require] = true
    optional!(name, opts)
  end

  def optional!(name, opts = {})
    if opts[:require] && !params.has_key?(name)
      raise ActionController::ParameterMissing.new(name)
    end

    if opts[:values] && params.has_key?(name)
      values = opts[:values].to_a
      if !values.include?(params[name]) && !values.include?(params[name].to_i)
        raise ParameterValueNotAllowed.new(name, opts[:values])
      end
    end

    params[name] ||= opts[:default]
  end

  def error!(data, status_code = 400)
    render json: data, status: status_code
  end

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
      error!({ message: '登录失败' }) and return if get_current_user.blank?
      Rails.logger.info("App#current_user ==> #{@current_user.id}/#{@current_user.nickname}")
    rescue JWT::VerificationError, JWT::DecodeError
      error!({ messgae: '授权失败' }, status_code = 401)
    rescue JWT::ExpiredSignature
      error!({ messgae: '授权已过期' }, status_code = 401)
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

end
