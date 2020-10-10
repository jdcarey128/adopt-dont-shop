Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
  get '/pets', to: 'pets#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
  get '/shelters/:shelter_id/pets', to: 'shelters#pets_index'
  get '/pets/:pet_id', to: 'pets#show'
  get '/shelters/:shelter_id/pets/new', to: 'shelters#pet_new'
  post '/shelters/:shelter_id/pets', to: 'shelters#pet_create'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id/pets', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'
end
