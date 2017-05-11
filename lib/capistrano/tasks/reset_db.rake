namespace :deploy do
  desc "reset database (dangerous!!!)"
  task :reset_db do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, ['db:drop db:create db:migrate']
        end
      end
    end
  end
end
