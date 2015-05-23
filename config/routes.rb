Rails.application.routes.draw do
  root            'topics#index'
  get 'terms'  => 'static#terms'
  get 'faq'    => 'static#faq'
  get 'stats'  => 'static#stats'

  resources :topics
  resources :posts
end
