Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root to: redirect('/api-docs')

  namespace :api do
    namespace :v1 do
      resources :students, only: %i[create destroy]
      resources :schools, only: [:index] do
        resources :classes, only: :index do
          resources :students, only: :index
        end
      end
    end
  end
end