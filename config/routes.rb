Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # example: Method api/v1/resources

  namespace :api do
    namespace :v1 do
      resources :businesses do
        resources :buy_orders, only: [:index]
      end
      resources :buy_orders
      resources :users

      resources :buyers do
        resources :businesses, only: [:index, :show], controller: 'api/v1/buyers/businesses'
        resources :buy_orders, only: [:index, :create], controller: 'api/v1/buyers/buy_orders'
      end

      resources :owners do
        resources :buy_orders, only: [:index, :update], controller: 'api/v1/owners/buy_orders'
      end
    end
  end

end
