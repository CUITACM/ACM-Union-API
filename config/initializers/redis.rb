# redis config
redis_connection = Redis.new(
  host: AcmUnionApi::REDIS_CONFIG['host'],
  port: AcmUnionApi::REDIS_CONFIG['port'],
  db: AcmUnionApi::REDIS_CONFIG['db'],
  timeout: AcmUnionApi::REDIS_CONFIG['time_out']
)

$redis ||= Redis::Namespace.new(AcmUnionApi::REDIS_CONFIG['app_ns'], :redis => redis_connection)