Rails.application.routes.draw do
  resource :mailer, only: [:show]
  resources :packages, only: [:edit, :update]
  mount_griddler

  root to: "landings#show"
end
