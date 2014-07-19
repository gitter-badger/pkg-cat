Rails.application.routes.draw do
  get "edit/:id", to: "packages#edit", as: :edit
  root to: "landings#show"
end
