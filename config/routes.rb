Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, except: [:new, :edit] do
      namespace :admin do
        resources :posts do
          patch :publish, :draft, :close
          get :filter, :today_statistics, on: :collection
        end

        resources :columns do
          post :members, to: 'columns#add_members'
        end

        resources :topics do
          post :members, to: 'topics#add_members'
          put  :members, to: 'topics#reset_members'
        end
      end

      resources :collections do
        post :members, to: 'collections#add_members'
        put  :members, to: 'collections#reset_members'
      end

      resources :posts, only: [:index, :show]
      resources :columns, only: [:index, :show]
    end
  end
end
