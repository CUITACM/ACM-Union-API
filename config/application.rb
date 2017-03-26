require_relative 'boot'
require_relative '../lib/json_web_token'
require_relative '../lib/achieve_center'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AcmUnionApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.autoload_paths << Rails.root.join('app/policies')
    config.autoload_paths << Rails.root.join('app/services')

    config.time_zone = 'Chongqing'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false

    config.encoding = 'utf-8'

    # CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :delete, :options]
      end
    end

    config.middleware.use Rack::Attack
  end

  # constants
  TOKEN_EXPIRES = Rails.env == 'production' ? 3.days.to_i : 28.days.to_i

  ACM_SPIDER_CONF = YAML.load(
    ERB.new(File.read(File.join(Rails.root, 'config', 'acm_spider.yml'))).result(binding)
  )[Rails.env]

  REDIS_CONFIG = YAML.load(
    ERB.new(File.read(File.join(Rails.root, 'config', 'redis.yml'))).result(binding)
  )[Rails.env]

end
