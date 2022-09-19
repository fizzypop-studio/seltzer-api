# frozen_string_literal: true

module ApplicationHelper
  def is_admin?
    return if current_user&.admin?

    respond_to do |format|
      format.json do
        render json: {
                 error: "You are not authorized to access this page."
               },
               status: :unauthorized
      end
      format.html do
        redirect_to root_path,
                    notice: "You are not authorized to access this page."
      end
    end
  end
end
