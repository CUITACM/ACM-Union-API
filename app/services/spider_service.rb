class SpiderService

  HOST = AcmUnionApi::ACM_SPIDER_CONF['host']
  PORT = AcmUnionApi::ACM_SPIDER_CONF['port']
  API_ROOT = "http://#{HOST}:#{PORT}"

  class << self

    def get_open_spider_workers
      begin
        HTTP.get("#{API_ROOT}/api/spider/workers").parse
      rescue => err
        raise "请求 get_open_spiders 失败! #{err.message}\n#{err.backtrace.join('\n')}"
      end
    end

    def open_spider_worker(oj_name)
      begin
        HTTP.post("#{API_ROOT}/api/spider/workers", form: {
          oj_name: oj_name
        }).parse
      rescue => err
        raise "请求 open_spider 失败! #{err.message}\n#{err.backtrace.join('\n')}"
      end
    end

    def stop_spider_worker(oj_name)
      begin
        HTTP.delete("#{API_ROOT}/api/spider/workers", form: {
          oj_name: oj_name
        }).parse
      rescue => err
        raise "请求 close_spider 失败! #{err.message}\n#{err.backtrace.join('\n')}"
      end
    end

    def get_rank_list(page, per)
      users = User.includes(:accounts).order('train_rank desc').page(page).per(per)
      rank_list = users.each_with_index.map do |user, index|
        order = (page.to_i - 1) * per.to_i + index + 1
        accounts = user.accounts
        accounts = ActiveModelSerializers::SerializableResource.new(accounts, {each_serializer: AccountSerializer}).as_json
        accounts = accounts[:accounts].map { |account| [account[:oj_name], account] }.to_h
        {order: order, user_id: user.id, user_name: user.display_name, train_rank: user.train_rank, accounts: accounts}
      end
      meta = {
        current_page: users.current_page,
        total_pages: users.total_pages,
        total_count: users.total_count
      }
      [rank_list, meta]
    end

  end

end