Rails.application.routes.draw do
  root                'topics#index'
  get    'terms'   => 'static#terms'
  get    'faq'     => 'static#faq'
  get    'stats'   => 'static#stats'
  get    'signup'  => 'users#new'
  get    'profile' => 'users#show'
  get    'queue'   => 'admin#index'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'private-messages', to: 'pm_topics#index',
                          as: 'pm_topics'
  post 'private-messages', to: 'pm_topics#create',
                           as: 'create_pm_topic'
  get 'private-messages/:id', to: 'pm_topics#show',
                              as: 'pm_topic'
  post 'private-messages/:id', to: 'pm_posts#create',
                               as: 'create_pm_topic_post'
  patch 'private-messages/:id', to: 'pm_topics#update',
                                as: 'update_pm_topic'
  get  'topics/:topic_id/posts/:post_id/contact', to: 'pm_topics#new',
                                                  as: 'new_pm_topic'
  get 'topics/:topic_id/posts/:id/new', to: 'posts#new',
                                        as: 'quote'
  get 'forgot-password', to: 'password_resets#new',
                         as: 'new_password_reset'
  get 'reset-password/:id/', to: 'password_resets#edit',
                             as: 'edit_password_reset'
  patch 'dismiss/:id/', to: 'admin#update',
                        as: 'dismiss'
  resources :users
  resources :posts
  resources :topics do
    resources :posts
  end
  resources :account_activations, only: :edit
  resources :password_resets,     only: [:create, :update]
  resources :pm_topics,           only: :create
  resources :pm_posts,            only: :create
end
