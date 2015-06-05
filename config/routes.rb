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
  get 'topics/:topic_id/posts/:id/new', to: 'posts#new',
                                        as: 'quote'
  get 'forgot-password', to: 'password_resets#new',
                         as: 'new_password_reset'
  get 'reset-password/:id/', to: 'password_resets#edit',
                             as: 'edit_password_reset'

  resources :users
  resources :posts
  resources :topics do
    resources :posts
  end
  resources :account_activations, only: :edit
  resources :password_resets,     only: [:create, :update]
end
