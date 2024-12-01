Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "books#index"

  resources :books, only: [:index, :show], param: :slug do
    get ':year', to: 'books#show', on: :member, as: :show_with_year, constraints: { year: /\d{4}/ }
    get ':year/:month', to: 'books#show', on: :member, as: :show_with_year_and_month, constraints: { year: /\d{4}/, month: /\d{1,2}/ }
  end
  resources :articles, only: [:index, :show]
end
