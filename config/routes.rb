Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        resources :contacts
      end
    end
  end

  devise_for :users,
             defaults: {
               format: :json
             },
             path: "",
             path_names: {
               sign_in: "api/v1/login",
               sign_out: "api/v1/logout",
               registration: "api/v1/signup"
             },
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }
end
