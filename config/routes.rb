Rails.application.routes.draw do
  root                'topics#index'
  get    'terms'   => 'static#terms'
  get    'faq'     => 'static#faq'
  get    'stats'   => 'static#stats'
  get    'signup'  => 'users#new'
  get    'profile' => 'users#show'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'posts/:topic_id/:id/new', to: 'posts#new', as: 'quote'

  resources :users
  resources :posts
  resources :topics do
    resources :posts
  end
  resources :account_activations, only: :edit
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
