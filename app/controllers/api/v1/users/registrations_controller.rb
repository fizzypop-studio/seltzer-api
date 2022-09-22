# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        skip_before_action :doorkeeper_authorize!,
                           only: %i[create send_reset_password reset_password]

        include DoorkeeperRegisterable

        def create
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          unless client_app
            return(
              render json: {
                       error: "Client Not Found. Check Provided Client Id."
                     },
                     status: :unauthorized
            )
          end

          allowed_params = user_params.except(:client_id)
          user = User.new(allowed_params)

          if user.save
            render json: render_user(user, client_app), status: :ok
          else
            render json: {
                     errors: user.errors.full_messages
                   },
                   status: :unprocessable_entity
          end
        end

        def update_profile
          user = current_user

          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          unless client_app
            return(
              render json: {
                       error: "Client Not Found. Check Provided Client Id."
                     },
                     status: :unauthorized
            )
          end
          allowed_params = user_params.except(:client_id, :client_secret)

          # If first_name, last_name, email or password are not provided, use existing email and password
          allowed_params[:first_name] = user.first_name if allowed_params[
            :first_name
          ].blank?
          allowed_params[:last_name] = user.last_name if allowed_params[
            :last_name
          ].blank?
          allowed_params[:email] = user.email if allowed_params[:email].blank?

          if user.update_without_password(allowed_params)
            render json: render_user(user, client_app), status: :ok
          else
            render json: {
                     errors: user.errors.full_messages
                   },
                   status: :unprocessable_entity
          end
        end

        def send_reset_password
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          unless client_app
            return(
              render json: {
                       error: "Client Not Found. Check Provided Client Id."
                     },
                     status: :unauthorized
            )
          end

          allowed_params =
            user_params.except(
              :first_name,
              :last_name,
              :password,
              :current_password,
              :client_id
            )
          user = User.find_by_email(allowed_params[:email])

          if user.present?
            user.send_reset_password_instructions
          elsif user.nil?
            render json: {
                     error: "Email not found. Please sign up or try again."
                   },
                   status: :bad_request
          else
            render json: {
                     error: user.errors.full_messages
                   },
                   status: :bad_request
          end
        end

        def reset_password
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])
          unless client_app
            return(
              render json: {
                       error: "Client Not Found. Check Provided Client Id."
                     },
                     status: :unauthorized
            )
          end

          allowed_params =
            user_params.except(
              :email,
              :first_name,
              :last_name,
              :current_password,
              :client_id,
              :client_secret
            )

          token =
            Devise.token_generator.digest(
              User,
              :reset_password_token,
              allowed_params["reset_password_token"]
            )

          user = User.find_by(reset_password_token: token)

          if user.present? && token.present?
            user.reset_password(
              allowed_params[:password],
              allowed_params[:password_confirmation]
            )
          elsif user.nil?
            render json: {
                     error:
                       "User not found for reset token. Please try to reset again."
                   },
                   status: :bad_request
          elsif token.nil?
            render json: {
                     error: "Invalid token. Please reset your password again."
                   },
                   status: :bad_request
          else
            render json: {
                     error: user.errors.full_messages
                   },
                   status: :bad_request
          end
        end

        private

        def check_valid_token?
          token =
            Devise.token_generator.digest(
              User,
              :reset_password_token,
              params["reset_password_token"]
            )
          user = User.find_by(reset_password_token: token)
          user.present?
        end

        def user_params
          params.permit(
            :email,
            :first_name,
            :last_name,
            :password,
            :password_confirmation,
            :current_password,
            :reset_password_token,
            :client_id
          )
        end
      end
    end
  end
end
