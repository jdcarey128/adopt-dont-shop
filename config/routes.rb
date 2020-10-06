Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/pets', to: 'pets#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
end
