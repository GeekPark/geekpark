Rails.application.config.after_initialize do
  config = File.join(Rails.root, 'config/cant_cant_cant.yml')
  CantCantCant.initialize(config) do |c|
    # aggressive: Inject validation to all controller actions
    # conservative: Inject validation only to those specified in config
    c.injection_mode = :aggressive
    c.injection_controller_base = ActionController
    c.injection_exceptions = []

    # Specify what to do for unspecfied access
    # c.default_policy = :allow

    # Should it raise an exception or ignore
    # c.report_unfilled_action = :ignore
  end
end
