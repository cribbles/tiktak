Rails.application.routes.draw do
  get 'static/terms'

  get 'static/faq'

  get 'static/stats'

  root           'application#hello'
  get 'terms' => 'static#terms'
  get 'faq'   => 'static#faq'
  get 'stats' => 'static#stats'
end
