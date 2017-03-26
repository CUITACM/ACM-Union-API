
redis_conn = Redis.new(
  host: AcmUnionApi::REDIS_CONFIG['host'],
  port: AcmUnionApi::REDIS_CONFIG['port'],
  db: AcmUnionApi::REDIS_CONFIG['db'],
  timeout: AcmUnionApi::REDIS_CONFIG['time_out']
)

$redis ||= Redis::Namespace.new(AcmUnionApi::REDIS_CONFIG['app_ns'], :redis => redis_conn)

AchieveCenter.configure do |config|
  config.redis = $redis
end

$achieve_center_client ||= AchieveCenter::Client.new


# Thread.new do
#   p 'start running AchieveCenter'
#   begin
#     while true
#       $achieve_center_client.run
#       sleep(2)
#     end
#   rescue => ex
#     Rails.logger.error(ex.message)
#   end
# end
