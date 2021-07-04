Rails.application.routes.draw do
  get 'api/users', to: 'user#index'
  get 'api/users/:id', to: 'user#show'
  post 'api/users', to: 'user#create'
  put  'api/users/:id', to: 'user#edit'
  delete 'api/users/:id', to: 'user#destroy'

  
  get 'api/books', to: 'book#index'
  get 'api/books/:id', to: 'book#show'
  put 'api/books/:id', to: 'book#edit'
  post 'api/books', to: 'book#create'
  delete 'api/books/:id', to: 'book#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
