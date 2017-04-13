module AchieveCenter

  class Client
    include Handler

    def initialize(options = {})

    end

    def run
      event_string = AchieveCenter.redis.lrange(AchieveCenter.mq_key, 0, 0)[0]
      event = Oj.load(event_string)
      case event['type']
      when 'submit'
        Spider.run_with_submit(event)
      else
        AchieveCenter.logger.error("[GameCenter] unknown event type #{event}")
      end
    end

  end

end