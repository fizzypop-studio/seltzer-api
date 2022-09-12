class Api::V1::ContactsController < Api::BaseController
  # GET /contacts
  def index
    @contacts = Contact.all
    render json: @contacts
  end

  # GET /contacts/:id
  def show
    @contact = Contact.find(params[:id])
    render json:
             ContactSerializer.new(@contact).serializable_hash[:data][
               :attributes
             ]
  end

  # POST /contacts/:id
  def update
    @contact = Contact.find(params[:id])

    if @contact
      @contact.update(contact_params)

      render json: {
               contact:
                 ContactSerializer.new(@contact).serializable_hash[:data][
                   :attributes
                 ],
               message: "Contact updated successfully."
             },
             status: :ok
    else
      render json: {
               message: "Unable to update contact."
             },
             status: :bad_request
    end
  end

  # DELETE /contacts/:id
  def destroy
    @contact = Contact.find(params[:id])

    if @contact
      @contact.destroy

      render json: {
               contact:
                 ContactSerializer.new(@contact).serializable_hash[:data][
                   :attributes
                 ],
               message: "Contact deleted successfully."
             },
             status: :ok
    else
      render json: {
               message: "Unable to delete contact."
             },
             status: :bad_request
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :first_name,
      :last_name,
      :email,
      :role,
      :user_id,
      :image
    )
  end

  def find_contact
    @contact = Contact.find(params[:id])
  end
end
