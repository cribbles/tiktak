Rails.application.routes.draw do
  get 'users/new'

  root            'topics#index'
  get 'terms'  => 'static#terms'
  get 'faq'    => 'static#faq'
  get 'stats'  => 'static#stats'

  resources :posts
  resources :topics do
    resources :posts
  end

  get 'topics/:topic_id/posts/:id/new', to: 'posts#new', as: 'quote'
end
