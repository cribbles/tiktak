Rails.application.routes.draw do
  root           'application#hello'
  get 'terms' => 'static#terms'
  get 'faq'   => 'static#faq'
  get 'stats' => 'static#stats'
end
