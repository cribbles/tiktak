Rails.application.routes.draw do
  root            'static#topics'
  get 'topics' => 'static#topics'
  get 'terms'  => 'static#terms'
  get 'faq'    => 'static#faq'
  get 'stats'  => 'static#stats'
end
