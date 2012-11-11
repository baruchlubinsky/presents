PresentsInThePost::Application.routes.draw do
  match 'home' => 'pages#home'
  match 'today' => 'pages#today'
  match 'posted_presents' => 'pages#posted_presents'
  match 'raj_loves' => 'pages#raj_loves'
  match 'about' => 'pages#about'
  match 'the_story' => 'pages#the_story'
  match 'get_a_present' => 'pages#get_a_present'
  match 'contact' => 'pages#contact'
  
  match 'cart/show' => 'carts#show'
  match 'cart/add_item' => 'carts#add_item'
  match 'cart/add_present' => 'carts#add_present'
  match 'cart/remove_item/:id' => 'carts#remove_item', :as => :cart_remove_item
  match 'checkout' => 'carts#checkout'
  
  match 'payment' => 'orders#payment'
  
  resources :users
  
  resources :authorisations
  
  resources :orders do
    collection do
      post 'search'
    end
    member do
      post 'payment'
      post 'success'
      post 'cancel'
      get 'mail'
    end
  end
  
  resources :presents
  
  resources :present_products
  
  resources :stories do
    member do
      get 'preview'
    end
    resources :blog_images
    resources :comments
  end
  
  resources :shops do
    member do
      get 'preview'
      post 'add_artist'
      post 'remove_artist'
    end
    collection do
      get 'admin'
    end
    resources :products do
      resources :images, :only => :destroy
    end
  end 
  
  resources :things
  
  resources :scroller_images

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
