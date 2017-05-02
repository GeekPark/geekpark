
namespace :cant_cant_cant do
  task :check do
    routes = Rails.application.routes.routes.to_a
    routes.reject! { |x| x.defaults[:internal] }
    actions = routes.map(&:defaults).reject(&:empty?).uniq
  end
end
