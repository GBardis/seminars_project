Rails.application.routes.draw do
  root "seminars#landing"
  resources :seminars do
    resources :images do
    end
  end
  resources :categories do
    resources :seminars do
    end
  end
  resources :photos
  get 'seminar/landing' => 'seminar#landing'
  devise_for :users, controllers: { registrations: 'registrations'}

end
