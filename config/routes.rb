Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'invite', to: 'static_pages#invite'
  match 'sendinvite', to: 'static_pages#sendinvite', via: 'post', as: :sendinvite
  match 'displaybooksearch', to: 'groups#displaybooksearch', via: 'get', as: :displaybooksearch

  match 'displayusersearch', to: 'groups#displayusersearch', via: 'get', as: :displayusersearch
  resources :users
  get 'users/dashboard'

  match 'users/:id/groups', to: 'users#groups', via: 'get', as: :groups_user
  post 'users/:id/requests/confirm', to: 'requests#confirm'
  post 'users/:id/requests/delete', to: 'requests#destroy'
  post '/searchbooks', to: 'groups#searchbooks'
  get '/searchbooks', to: 'groups#searchbooks'
  post '/searchusers', to: 'groups#searchusers'
  get '/searchusers', to: 'groups#searchusers'
  post 'groups/finish_book', to: 'groups#finish_book'
  match 'groups/:id/list', to: 'groups#list', via: 'get', as: :groups_list
  

  resources :groups, only: [:new, :show, :create, :destroy] do
    get :autocomplete_user_name, :on => :collection
    get :autocomplete_book_title, :on => :collection
  end
  resources :requests, only: [:create, :destroy, :update]
  resources :notes
  resources :books, only: [:show]

  root :to => 'static_pages#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
