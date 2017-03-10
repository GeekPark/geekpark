ActiveModelSerializers.config.tap do |config|
  # config.adapter = :json_api # Default: `:attributes`
  config.adapter = :JSON
  # config.key_transform = :underscore
end
