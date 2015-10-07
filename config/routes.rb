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
    resources :commits, only: [:create, :show] do
      resources :comments, only: [:create, :update]
    end
  end

  root 'welcome#index'

end
