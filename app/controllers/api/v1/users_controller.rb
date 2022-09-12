class Api::V1::UsersController < Api::BaseController
  before_action :find_user, only: %w[show]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
  end

  # POST /users/:id
  def update
    @user = User.find(params[:id])

    if @user
      @user.update(user_params)

      render json: {
               user:
                 UserSerializer.new(@user).serializable_hash[:data][
                   :attributes
                 ],
               message: "User updated successfully."
             },
             status: :ok
    else
      render json: { message: "Unable to update user." }, status: :bad_request
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])

    if @user
      @user.destroy

      render json: {
               user:
                 UserSerializer.new(@user).serializable_hash[:data][
                   :attributes
                 ],
               message: "User deleted successfully."
             },
             status: :ok
    else
      render json: { message: "Unable to delete user." }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :image
    )
  end

  def find_user
    @user = User.find(params[:id])
  end
end
