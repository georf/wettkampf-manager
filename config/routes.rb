Rails.application.routes.draw do
  root 'dashboard#show'

  get :logout, to: "sessions#destroy", as: :logout
  get :login, to: "sessions#new", as: :login
  get :flyer, to: 'dashboard#flyer'
  get :impressum, to: 'dashboard#impressum'
  resources :sessions, only: [:create]
  resources :users

  resources :presets, only: [:index, :show, :update]
  resource :competitions, only: [:show, :edit, :update]
  resources :disciplines
  resources :assessments do
    member { get :possible_associations }
  end
  resources :people do
    member do
      get :edit_assessment_requests
      get :statistic_suggestions
    end
    collection { get :without_statistics_id }
  end
  resources :teams do
    member do
      get :edit_assessment_requests
      get :statistic_suggestions
    end
    collection { get :without_statistics_id }
  end
  namespace :score do
    resource :list_factories, only: [:new, :create, :edit, :update, :destroy]
    resources :lists, only: [:show, :edit, :update, :index, :destroy] do
      member do
        get :move
        get :select_entity
        get "destroy_entity/:entry_id", action: :destroy_entity, as: :destroy_entity
        get :edit_times
      end
      resources :runs, only: [:edit, :update], param: :run
    end
    resources :results
    resources :competition_results, only: [:new, :create, :index, :edit, :update, :destroy]
  end

  namespace :fire_sport_statistics do
    resources :suggestions, only: [] do
      collection do
        get :people
        get :teams
      end
    end
  end

  namespace :certificates do
    resources :templates
    resources :lists, only: [:new, :create] do
      collection do
        post :export
      end
    end
  end

  namespace :imports do
    resources :configurations
  end

  namespace :series do
    resources :rounds, only: [:index, :show]
    resources :assessments, only: [:show]
  end

  namespace :api do
    resources :time_entries, only: [:index, :show, :edit, :update, :create] do
      member do
        patch :ignore
      end
    end
  end
end

