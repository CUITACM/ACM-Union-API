class SpiderService

  HOST = AcmUnionApi::ACM_SPIDER_CONF['host']
  PORT = AcmUnionApi::ACM_SPIDER_CONF['port']
  API_ROOT = "http://#{HOST}:#{PORT}"

  class << self
    def get_open_spider_workers
      begin
        HTTP.get("#{API_ROOT}/api/spider/workers").parse
      rescue => err
        raise "请求 get_open_spiders 失败! #{err.backtrace}\n"
      end
    end

    def open_spider_worker(oj_name)
      begin
        HTTP.post("#{API_ROOT}/api/spider/workers", form: {
          oj_name: oj_name
        }).parse
      rescue => err
        raise "请求 open_spider 失败! #{err.backtrace}\n"
      end
    end

    def close_spider_worker(oj_name)
      begin
        HTTP.delete("#{API_ROOT}/api/spider/workers", form: {
          oj_name: oj_name
        }).parse
      rescue => err
        raise "请求 close_spider 失败! #{err.backtrace}\n"
      end
    end

  end

end