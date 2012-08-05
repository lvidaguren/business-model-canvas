BuissnessModelCanvas::Application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end
  
  # Invitations
  post 'invitations/invite' => 'invitations#invite', as: :invite
  
  # Board
  resources :boards, only: [:new, :show, :update, :index] do
    get 'sections/:handler' => 'boards#section', on: :member, as: :section
  end
  
  # TODO remove the following comments
  # get 'boards/new' => 'boards#new', as: :new_board
  # get 'boards/:key' => 'boards#show', as: :board
  # post 'boards/:key' => 'boards#update'
  # get 'board/:key/section/:handler' => 'boards#section', as: :section

  # Cards
  post 'cards/update' => 'cards#update'
  resources :cards do
    resources :comments, only: [:create, :index, :destroy]
  end
  
  # TODO remove the following comments
  #post 'cards(.format)' => 'cards#create'
  #get 'cards/:id/comments' => 'comments#index'
  #delete 'cards/:id' => 'cards#destroy'
  #post 'cards/update' => 'cards#update'
  #post 'cards/:id/comments' => 'comments#create', as: :card_comments
  
  root :to => 'home#index'

  resources :contacts, only: [:new, :create]
  match 'contact-us' => 'contacts#new', as: :contact_us
  
  post 'home/save'
  get 'home/load'
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
