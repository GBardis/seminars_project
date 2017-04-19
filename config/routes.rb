Rails.application.routes.draw do
  root "seminars#index"
  resources :seminars do
    resources :images do
    end
  end
  devise_for :users, controllers: { registrations: 'registrations'}

end
