Rails.application.routes.draw do
  get 'api/books', to: 'api#index'
  get 'api/books/:id', to: 'api#show'
  put 'api/books/:id', to: 'api#edit'
  post 'api/books', to: 'api#create'
  put 'api/books/:id', to: 'api#update'
  delete 'api/books/:id', to: 'api#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
