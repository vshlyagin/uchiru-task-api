Rails.application.routes.draw do
  resources :students, only: %i[create destroy]

  resources :schools, only: [] do
    resources :school_classes, only: :index do
      resources :students, only: :index, module: :school_classes
    end
  end
end