Apipie.configure do |config|
  config.app_name                = "Geekpark"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.languages               = ['zh-CN', 'en']
  config.default_locale          = 'en'
  config.validate                = false
  config.namespaced_resources    = true
  config.use_cache               = Rails.env.production?
  config.markup                  = Object.new.tap do |o|
    def o.to_html(txt)
      MarkdownEngine.render_html(txt)
    end
  end
end
