# redis config
redis_connection = Redis.new(host: '127.0.0.1', port: 6379, db: 1)
$redis = Redis::Namespace.new('cuit_acm', :redis => redis_connection)