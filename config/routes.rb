Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#show", as: :home

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index", as: :items
  get "/items/:id", to: "items#show", as: :item
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"
  patch "/cart/:item_id/:increment_decrement", to: "cart#increment_decrement"

  get "/orders/new", to: "orders#new"
  get "/orders/:id", to: "orders#show"

  get '/register', to: 'users#new', as: :registration
  post '/users', to: 'users#create'
  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update', as: :user_update
  get '/profile', to: 'users#show', as: :profile
  get '/profile/edit_password', to: 'users#edit_password', as: :profile_edit_password
  patch '/profile/edit_password', to: 'users#update_pass'

  get '/profile/orders', to: 'users/orders#index', as: :user_orders
  post "/profile/orders", to: "users/orders#create", as: :order_create
  get '/profile/orders/:id', to: 'users/orders#show', as: :user_order
  patch '/profile/orders/:id', to: 'users/orders#cancel'

  get '/employee', to: 'employee/dashboard#show', as: :employee_dashboard

  get '/admin', to: 'admin/dashboard#show', as: :admin_dashboard
  get '/admin/users/:id', to: 'admin/dashboard#user_show', as: :admin_user_show
  patch '/admin', to: 'admin/dashboard#ship', as: :admin_ship_order

  get '/merchant', to: 'merchant/dashboard#show', as: :merchant_dashboard

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
end
