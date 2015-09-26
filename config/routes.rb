Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  
  resources :orders
  resources :combos
  resources :offers
  resources :user_details
  resources :user_products
  resources :service_scores
  resources :product_scores
  # resources :offer_details

  post '/offer_details/edit' => 'offer_details#edit', as: 'edit_offer_details'
  post '/offer_details/create' => 'offer_details#create', as: 'offer_details'
  post '/orders/:id/edit' => 'orders#edit', as: 'lock_order'
  post '/combos/create' => 'combos#create',  as: 'create_combo'  
  get 'from_order/:id' => "offers#from_order", as: 'from_order'
  # login
  get '/welcome/index' => "welcome#index"
  # edit user settings
  get '/settings' => 'user_settings#index', as: 'settings'
  # history
  get '/history' => 'history#show', as: 'history'
  get '/history/:id/order/' => 'order_histories#show', as: 'order_history'

  # admin_dashboard
  get '/admin_dashboard' =>'users#admin_index', as: 'admin'



  # feedback
  get '/review_tickets' => 'review_tickets#index', as: 'review_tickets'
  # edit user information
  # get '/user_details' => 'user_details#edit', as: 'edit_user_details'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'orders#index'

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
