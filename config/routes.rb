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
  get 'private-messages', to: 'pm_topics#index',
                          as: 'pm_topics'
  post 'private-messages', to: 'pm_topics#create',
                           as: 'create_pm_topic'
  get 'private-messages/:pm_topic_id', to: 'pm_posts#new',
                                       as: 'new_pm_topic_post'
  get  'topics/:topic_id/posts/:post_id/contact', to: 'pm_topics#new',
                                                  as: 'new_pm_topic'
#  post 'topics/:topic_id/posts/:post_id/contact', to: 'pm_topics#create',
#                                                  as: 'create_pm_topic'
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
  resources :pm_topics,           only: :create
  resources :pm_posts,            only: :create
end
