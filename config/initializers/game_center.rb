
redis_conn = Redis.new(
  host: AcmUnionApi::REDIS_CONFIG['host'],
  port: AcmUnionApi::REDIS_CONFIG['port'],
  db: AcmUnionApi::REDIS_CONFIG['db'],
  timeout: AcmUnionApi::REDIS_CONFIG['time_out']
)

$redis ||= Redis::Namespace.new(AcmUnionApi::REDIS_CONFIG['app_ns'], :redis => redis_conn)

GameCenter.configure do |config|
  config.redis = $redis
end

$game_center_client ||= GameCenter::Client.new

#
# Thread.new do
#   while true
#     p 'thread is running'
#     sleep(2)
#   end
# end
