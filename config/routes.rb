Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  root                'topics#index'
  get    'terms'   => 'static#terms'
  get    'faq'     => 'static#faq'
  get    'stats'   => 'static#stats'
  get    'signup'  => 'users#new'
  get    'profile' => 'users#show'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
  resources :posts
  resources :topics do
    resources :posts
  end

  get 'posts/:topic_id/:id/new', to: 'posts#new', as: 'quote'
end
