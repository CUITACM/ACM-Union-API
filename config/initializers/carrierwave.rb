CarrierWave.configure do |config|
  config.storage = :file
  config.permissions = 0664
end