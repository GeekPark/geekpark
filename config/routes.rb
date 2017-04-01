Rails.application.routes.draw do
  apipie

  namespace :api do
    namespace :v1, except: [:new, :edit] do
      root to: 'home#web_index'
      resources :collections, only: [:index, :show]

      resources :posts, only: [:index, :show] do
        resources :comments, only: [:index, :create]
      end
      resources :columns, only: [:index, :show]

      namespace :admin do
        resources :posts do
          patch :publish, :draft, :close
          get :filter, :today_statistics, on: :collection

          get :comments, to: 'comments#index_for_commentable'
        end

        resources :ads do
          get :comments, to: 'comments#index_for_commentable'
        end

        resources :columns do
          post :members, to: 'columns#add_members'
        end

        resources :topics do
          post :members, to: 'topics#add_members'
          put  :members, to: 'topics#reset_members'
        end

        resources :comments, only: [:index, :destroy] do
          patch  :spam, to: 'comments#set_spam'
          delete :spam, to: 'comments#unset_spam'

          get :filter, on: :collection
        end

        resources :collections, only: [:index, :update, :destroy] do
          post :members, to: 'collections#add_members'
          put  :members, to: 'collections#reset_members'
        end
      end
    end
  end
end
