PresentsInThePost::Application.routes.draw do

  resources :users
  
  resources :authorisations
  
  resources :orders
  
  resources :presents
  
  resources :present_products
  
  resources :stories do
    resources :blog_images
    resources :comments
  end
  
  resources :shops do
    resources :products do
      resources :images, :only => :destroy
    end
  end 
  
  resources :things
  
  match 'home' => 'pages#home'
  match 'news' => 'pages#news'
  match 'past_presents' => 'pages#past_presents'
  match 'things_i_like' => 'pages#things_i_like'
  match 'about' => 'pages#about'
  match 'shop' => 'pages#shop'
  
  match 'login' => 'authorisations#new'
  match 'logout' => 'authorisations#destroy'
  
  root :to => 'pages#home'

  match 'admin' => 'admins#index'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
