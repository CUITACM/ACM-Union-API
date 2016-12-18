require 'open-uri'

class SpiderService

  HOST = AcmUnionApi::ACM_SPIDER_CONF['host']
  PORT = AcmUnionApi::ACM_SPIDER_CONF['port']
  API_ROOT = "http://#{HOST}:#{PORT}"

  class << self
    def get_open_spiders
      begin
        open("#{API_ROOT}/api/spider/runners") { |f| f.read }
      rescue
        raise '请求 /api/spider/runners 失败!'
      end
    end
  end

end