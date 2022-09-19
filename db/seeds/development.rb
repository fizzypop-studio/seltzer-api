# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(
    name: "React Client",
    redirect_uri: "",
    scopes: ""
  )
end

User.first_or_create(
  email: "test@example.com",
  first_name: "Test",
  last_name: "User",
  password: "password",
  password_confirmation: "password",
  role: User.roles[:admin]
)
