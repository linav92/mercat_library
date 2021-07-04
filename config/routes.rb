Rails.application.routes.draw do
  get 'book/books', to: 'book#index'
  get 'book/books/:id', to: 'book#show'
  put 'book/books/:id', to: 'book#edit'
  post 'book/books', to: 'book#create'
  put 'book/books/:id', to: 'book#update'
  delete 'book/books/:id', to: 'book#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
