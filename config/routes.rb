Rails.application.routes.draw do
  
  resources :products
  root 'users#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  devise_for :users 

  devise_scope :user do
    #root :to => 'devise/sessions#new'
    get "login", :to => "devise/sessions#new"
    get "register", :to => "devise/registrations#new" , :controllers => {:registrations => 'registrations'}
    get "settings", :to => "devise/registrations#edit"
    get "logout",   :to => "devise/sessions#destroy"

  end

  #devise_for :users , :controllers => {:registrations => 'registrations'}

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

      get 'users' => 'users#index'
      get 'users/:id' => 'users#show'
      get 'members_home' => 'users#members_home'
      post 'punch' => 'users#punch'
      get 'history/:id' => 'histories#show'
      #get 'user_details/new' => 'user_details#new'
      #post 'user_details' => 'user_details#create'
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
      resources :user_details
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
