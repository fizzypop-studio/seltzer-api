# frozen_string_literal: true

module Api
  module V1
    module Users
      class ContactsController < ApiController
        before_action :set_contact, only: %i[show update destroy]
        before_action :doorkeeper_authorize!
        before_action :current_user
        respond_to :json

        # GET /contacts or /contacts.json
        def index
          @contacts = Contact.where({ user_id: @current_user.id })
          contact_map =
            @contacts.map do |contact|
              {
                id: contact.id,
                first_name: contact.first_name,
                last_name: contact.last_name,
                email: contact.email,
                role: contact.role,
                created_at: contact.created_at.iso8601
              }
            end
          render json: contact_map, status: :ok
        end

        # GET /contacts/1 or /contacts/1.json
        def show
          if current_user && @contact.user_id == current_user.id
            render json: {
                     id: @contact.id,
                     first_name: @contact.first_name,
                     last_name: @contact.last_name,
                     email: @contact.email,
                     role: @contact.role,
                     created_at: @contact.created_at.iso8601
                   },
                   status: :ok
          else
            render json: { error: "Cannot find contact." }, status: :bad_request
          end
        end

        # POST /contacts or /contacts.json
        def create
          allowed_params = contact_params.except(:token)
          @contact = Contact.new(allowed_params)

          if @contact.save
            render json: {
                     id: @contact.id,
                     first_name: @contact.first_name,
                     last_name: @contact.last_name,
                     email: @contact.email,
                     role: @contact.role,
                     created_at: @contact.created_at.iso8601
                   },
                   status: :ok
          else
            render json: {
                     error:
                       "Something went wrong creating Contact. Please try again."
                   },
                   status: :bad_request
          end
        end

        # PATCH/PUT /contacts/1 or /contacts/1.json
        def update
          allowed_params = contact_params.except(:user_id, :token)

          if @contact.update(allowed_params)
            render json: {
                     id: @contact.id,
                     first_name: @contact.first_name,
                     last_name: @contact.last_name,
                     email: @contact.email,
                     role: @contact.role,
                     created_at: @contact.created_at.iso8601
                   },
                   status: :ok
          else
            render json: {
                     error:
                       "Something went wrong updating Contact. Please try again."
                   },
                   status: :bad_request
          end
        end

        # DELETE /contacts/1 or /contacts/1.json
        def destroy
          if @contact.destroy
            render json: {
                     id: @contact.id,
                     first_name: @contact.first_name,
                     last_name: @contact.last_name,
                     email: @contact.email,
                     role: @contact.role,
                     created_at: @contact.created_at.iso8601
                   },
                   status: :ok
          else
            render json: {
                     error:
                       "Something went wrong deleting Contact. Please try again."
                   },
                   status: :bad_request
          end
        end

        private

        # Only allow a list of trusted parameters through.
        def contact_params
          params.permit(
            :id,
            :email,
            :first_name,
            :last_name,
            :role,
            :user_id,
            :token
          )
        end

        def set_contact
          @contact = Contact.find_by_id(params[:id])
          if @contact.nil?
            render json: { error: "Contact not found" }, status: :not_found
          end
        end
      end
    end
  end
end
