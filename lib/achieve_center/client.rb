module AchieveCenter

  class Client
    include Handler
    include Event

    def initialize(options = {})

    end

    def run
      event_string = AchieveCenter.redis.brpop(AchieveCenter.mq_key)
      event = Oj.load(event_string)
      case event['type']
      when 'submit'
        Spider.handle_submit(event)
      when 'blog'
        Blog.handle(event)
      else
        AchieveCenter.logger.error("[GameCenter] unknown event type #{event}")
      end
    end

  end

end