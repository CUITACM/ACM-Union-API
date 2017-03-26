Dir["#{File.dirname(__FILE__)}/handler/*.rb"].each do |path|
  require path
end