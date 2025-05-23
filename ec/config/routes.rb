Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # ユーザーリソースルーター
  namespace :user do
    get "new", to: "users#new", as: :new_user
    post "create", to: "users#create", as: :create_user
    get "login", to: "users#login", as: :login_user
    post "auth", to: "users#auth", as: :auth_user
    get "logout", to: "users#logout", as: :logout_user
  end

  # タスクリソースルーター
  namespace :task do
    get "list", to: "tasks#index", as: :tasks
    get "new", to: "tasks#new", as: :new_task
    post "create", to: "tasks#create", as: :create_task
    get "edit/:task_id", to: "tasks#edit", as: :edit_task
    post "update/:task_id", to: "tasks#update", as: :update_task
    delete "delete/:task_id", to: "tasks#delete", as: :delete_task
  end
end
