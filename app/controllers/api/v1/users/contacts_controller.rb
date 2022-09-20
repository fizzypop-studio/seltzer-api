# frozen_string_literal: true

module Api
  module V1
    module Users
      class ContactsController < ApiController
        before_action :doorkeeper_authorize!
        before_action :current_user
        respond_to :json

        # GET /contacts or /contacts.json
        def index
          if @current_user.nil?
            render json: { error: "Not Authorized" }, status: :unauthorized
          else
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
        end

        # GET /contacts/1 or /contacts/1.json
        def show
          render json: @contact
        end

        # POST /contacts or /contacts.json
        def create
          @contact = Contact.new(contact_params)

          respond_to do |format|
            if @contact.save
              format.html do
                redirect_to api_v1_user_contact_url(@contact),
                            notice: "Contact was successfully created."
              end
              format.json { render :show, status: :created, location: @contact }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json do
                render json: @contact.errors, status: :unprocessable_entity
              end
            end
          end
        end

        # PATCH/PUT /contacts/1 or /contacts/1.json
        def update
          respond_to do |format|
            if @contact.update(contact_params)
              format.html do
                redirect_to api_v1_contact_url(@contact),
                            notice: "Contact was successfully updated."
              end
              format.json { render :show, status: :ok, location: @contact }
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json do
                render json: @contact.errors, status: :unprocessable_entity
              end
            end
          end
        end

        # DELETE /contacts/1 or /contacts/1.json
        def destroy
          @contact.destroy

          respond_to do |format|
            format.html do
              redirect_to api_v1_contacts_url,
                          notice: "Contact was successfully destroyed."
            end
            format.json { head :no_content }
          end
        end

        private

        # Only allow a list of trusted parameters through.
        def contact_params
          params.require(:contact).permit(
            :id,
            :email,
            :first_name,
            :last_name,
            :role,
            :user_id
          )
        end
      end
    end
  end
end
