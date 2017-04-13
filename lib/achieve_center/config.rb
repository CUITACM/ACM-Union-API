module AchieveCenter

  class << self
    attr_accessor :config, :logger

    def configure
      yield self.config ||= Config.new
    end

    def redis
      return nil if config.nil?
      @redis ||= config.redis
    end

    def logger
      return Rails.logger if config.nil?
      @logger = config.logger
    end

    def mq_key
      'achievement_queue'
    end
  end

  class Config
    attr_accessor :redis, :logger
  end
end