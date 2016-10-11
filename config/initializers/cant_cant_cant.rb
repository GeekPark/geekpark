Rails.application.config.after_initialize do
  config = File.join(Rails.root, 'config/cant_cant_cant.yml')
  CantCantCant.initialize(config)
end
