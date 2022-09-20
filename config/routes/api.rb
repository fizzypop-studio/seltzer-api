# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    scope :users, module: :users do
      post "/", to: "registrations#create", as: :user_registration
      patch "/", to: "registrations#update_profile", as: :user_update_profile
      post "/send-reset-password",
           to: "registrations#send_reset_password",
           as: :user_send_reset_password
      put "/reset-password",
          to: "registrations#reset_password",
          as: :user_reset_password
      get "/contacts", to: "contacts#index", as: :user_contacts
    end

    get "/users/me", to: "users#me"
  end
end

scope :api do
  scope :v1 do
    # Swagger documentation
    scope :swagger do
      get "/", to: "apidocs#index", as: :swagger_root
      get "/data", to: "apidocs#data", as: :swagger_data
    end
    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end
  end
end
