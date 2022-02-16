Rails.application.routes.draw do

  resources :reviews
  root "movies#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies

end
