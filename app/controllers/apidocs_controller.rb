# frozen_string_literal: true

class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :openapi, "3.0.0"

    info do
      key :version, "1.0.0"
      key :title, "Seltzer API"
      key :description, "Seltzer API Documentation"

      contact do
        key :name, "Seltzer API Starter"
        key :email, "sethcarrino@gmail.com"
      end
    end

    server do
      key :url, "#{Rails.env.development? ? "localhost:3000" : ""}/api/v1/"
      key :description, "Seltzer API"
    end
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    Swagger::Controllers::Users::TokensController,
    Swagger::Controllers::Users::RegistrationsController,
    Swagger::Responses::Users::TokenResponses,
    Swagger::Responses::Users::RegistrationResponses,
    Swagger::Responses::ErrorResponse,
    Swagger::Inputs::Users::TokenInputs,
    Swagger::Inputs::Users::RegistrationInput,
    self
  ].freeze

  def index
    render html: nil, layout: "swagger"
  end

  def data
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
