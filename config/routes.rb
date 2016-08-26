Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/about', controller: "welcome", action: "about"
  get '/privacy', controller: "welcome", action: "privacy"
  resources :searches
  resources :suburbs
  resources :schools do
    resources :reviews
  end
end
