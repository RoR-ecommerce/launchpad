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
end
