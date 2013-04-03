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

  get  '/oauth/auth'  => 'oauth/auth#auth'
  post '/oauth/token' => 'oauth/token#create'

  get  'oauth/user'   => 'oauth/user#user'
end
