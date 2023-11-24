Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  get "/products/new", to: "products#new", as: :new_product
  post "/products", to: "products#create"
  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
  patch '/products/:id', to: 'products#update'
  get '/products/:id/edit', to: 'products#edit', as: :edit_product
  
  get "/about_us", to: "pages#about", as: :about 
  get "/privacy", to: "pages#privacy", as: :privacy
  root "products#index"
end
