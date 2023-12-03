Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # example: Method api/v1/resources

  namespace :api do
    namespace :v1 do
      resources :businesses
      resources :users

      resources :buyers do
        resources :businesses, only: [:index, :show], controller: 'buyers/businesses'
        resources :buy_orders, only: [:index, :create], controller: 'buyers/buy_orders'
      end

      resources :owners do
        resources :businesses, only: [:index, :create, :delete], controller: 'owners/businesses'
        resources :buy_orders, only: [:index, :update], controller: 'owners/buy_orders'
      end
    end
  end

end
