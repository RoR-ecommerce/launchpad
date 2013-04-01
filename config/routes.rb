Launchpad::Application.routes.draw do
  devise_for :users,
    path_names: {
      sign_in:  'login',
      sign_out: 'logout'
    },
    controllers: {
      registrations: 'users/registrations',
      passwords:     'users/passwords'
    }

  root to: 'home#index'

  match '/oauth/auth/new' => 'oauth/auth#new',     via: :get
  match '/oauth/auth'     => 'oauth/auth#create',  via: :post
  match '/oauth/token'    => 'oauth/token#create', via: :post
end
