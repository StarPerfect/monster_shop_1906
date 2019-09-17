Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#show", as: :home

  get "/merchants", to: "merchants#index"
  get "/merchants/:id", to: "merchants#show"

  get "/items", to: "items#index", as: :items
  get "/items/:id", to: "items#show", as: :item
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

  get '/profile/addresses', to: 'addresses#show'

  get '/employee', to: 'employee/dashboard#show', as: :employee_dashboard

  get '/admin', to: 'admin/dashboard#show', as: :admin_dashboard
  patch '/admin', to: 'admin/dashboard#ship', as: :admin_ship_order
  get '/admin/merchants', to: 'admin/dashboard#index'
  get '/admin/merchants/:id', to: 'admin/dashboard#merchant_show', as: :admin_merchant_show
  patch '/admin/merchants/:id', to: 'admin/dashboard#able', as: :able
  get '/admin/users', to: 'admin/users#index', as: :admin_users
  get '/admin/users/:id', to: 'admin/users#show', as: :admin_user_show

  get '/merchant', to: 'merchant/dashboard#show', as: :merchant_dashboard
  get '/merchant/orders/:id', to: 'employee/dashboard#order_show', as: :merchant_order_show
  get '/merchant/items', to: 'merchant/dashboard#index', as: :merchant_items
  patch '/merchant/items', to: 'merchant/dashboard#item_status', as: :item_status
  patch '/merchant/orders/:id', to: 'employee/dashboard#update', as: :fulfill
  delete '/merchant/items', to: 'merchant/dashboard#destroy', as: :delete_item
  get "/merchant/items/new", to: "merchant/dashboard#new", as: :new_item
  post '/items', to: "merchant/dashboard#create"
  get '/merchant/items/edit', to: "merchant/dashboard#edit", as: :edit_item
  patch '/merchant/items/:id', to: "merchant/dashboard#item_update", as: :update_item

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :users, only: [] do
    resources :addresses, shallow: true #allows for the uncomplicated nested route paths while still keeping resource nested
  end
end
