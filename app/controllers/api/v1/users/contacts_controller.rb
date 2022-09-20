# frozen_string_literal: true

module Api
  module V1
    module Users
      class ContactsController < ApiController
        before_action :set_contact, only: %i[show edit update destroy]

        # GET /contacts or /contacts.json
        def index
          @contacts = Contact.all
          render json: @contacts
        end

        # GET /contacts/1 or /contacts/1.json
        def show
          render json: @contact
        end

        # GET /contacts/new
        def new
          render json: @contact = Contact.new
        end

        # GET /contacts/1/edit
        def edit
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

        # Use callbacks to share common setup or constraints between actions.
        def set_contact
          @contact = Contact.find_by_id(params[:id])
          if @contact.nil?
            render json: { error: "Contact not found" }, status: :not_found
          end
        end

        # Only allow a list of trusted parameters through.
        def contact_params
          params.require(:contact).permit(:title, :body)
        end
      end
    end
  end
end
