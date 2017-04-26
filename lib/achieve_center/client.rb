module AchieveCenter

  class Client
    include Handler
    include Event

    def initialize(options = {})

    end

    def run
      return false if AchieveCenter.redis.llen(AchieveCenter.mq_key) == 0
      begin
        return_value = AchieveCenter.redis.brpop(AchieveCenter.mq_key)
        return false if return_value.blank?
        
        event_string = return_value[1]
        AchieveCenter.logger.debug("fetch event from redis => #{event_string}")
        event = Oj.load(event_string)
        case event['type']
        when 'submit'
          Spider.handle_submit(event)
        when 'blog'
          Blog.handle(event)
        else
          throw "[GameCenter] unknown event type #{event}"
          AchieveCenter.logger.error("[GameCenter] unknown event type #{event}")
        end
      rescue => error
        AchieveCenter.logger.error("[GameCenter] #{error.message}\n#{error.traceback.join('\n')}")
      end
      return true
    end

  end

end