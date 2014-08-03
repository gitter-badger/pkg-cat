Rails.application.routes.draw do
  get "edit/:id", to: "packages#edit", as: :edit
  resource :mailer, only: [:show]
  root to: "landings#show"
end
