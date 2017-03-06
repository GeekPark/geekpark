Rails.application.config.after_initialize do
  perm_file = File.join(Rails.root, 'config/cant_cant_cant.yml')
  CantCantCant.initialize(perm_file) do |c|
    # base_controller: Inject validation to the base controller
    # individual:      Inject validation only to actions specified in config
    c.injection_mode = :base_controller
    c.base_controller = API::V1::APIController

    # Specify what to do for unlisted access
    c.default_policy = :allow

    # warn:   print a warning for unlisted actions and adopt default_policy
    # raise:  raise an exception for unlisted actions
    # ignore: ignore validation on unlisted actions and adopt default_policy
    c.report_unlisted_actions = :warn

    # load permission from file for every request for cache them
    c.caching = Rails.env.production?
  end
end
