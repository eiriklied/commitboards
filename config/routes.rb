Commitboards::Application.routes.draw do

  post 'oauth/callback'  => 'oauths#callback'
  get  'oauth/callback'  => 'oauths#callback'
  get  'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  resource :session , only: [:new, :destroy]
  get 'session/new/:board_id' => 'sessions#new', as: :new_session_from_board

  resource :dashboard, only: :show



  scope :downloads do
    get 'capture'   => 'scripts#capture_script',                     as: 'capture_script'
    get 'bgcapture' => 'scripts#background_capture_script',          as: 'background_capture_script'
    get 'update_and_capture' => 'scripts#update_and_capture_script', as: 'update_and_capture_script'
    get 'imagesnap' => 'scripts#imagesnap',                          as: 'imagesnap'
    get 'version'   => 'scripts#version',                            as: 'version'
  end
  # need an alias for the version checking, since all the distributed scripts have a board url
  get ':board_id/version' => 'scripts#version'

  get 'install/:token' => 'scripts#install', as: 'install'
  # just an alias to the install script as client scripts for commitboards
  # have access to the board url. Then its easy to append /install/<token>
  get ':board_id/install/:token' => 'scripts#install'

  resources :boards, path: '/', only: [:show, :create] do
    member do
      get :incoming
    end
    resources :commits, only: [:create, :show] do
      resources :comments, only: [:create]
    end
  end

  root 'welcome#index'

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
