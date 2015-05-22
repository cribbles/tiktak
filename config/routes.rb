Rails.application.routes.draw do
  root            'topics#index'
  get 'topics' => 'topics#index'
  get 'terms'  => 'static#terms'
  get 'faq'    => 'static#faq'
  get 'stats'  => 'static#stats'
end
