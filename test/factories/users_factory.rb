# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password do
      Faker::Internet.password(min_length: Devise.password_length.first)
    end
  end
end
