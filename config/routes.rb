Rails.application.routes.draw do
  resources :urls
  get ':short_url', to: 'urls#redirect'
  root to: 'urls#index'
end
