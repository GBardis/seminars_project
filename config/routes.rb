Rails.application.routes.draw do
  get 'sessions/new'

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

#authentication 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end
