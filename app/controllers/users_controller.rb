class UsersController < ApplicationController
  def new
    render "users/register"
  end

  def create
    user = User.new(email: user_params[:email], password: user_params[:password], username: user_params[:username])
    if user.save
      session[:user_id] = user.id
      render json: { message: index_path }, status: 200
    else
      render json: { message: model_errors_json(user) }, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :username, :password, :token, :new_password)
  end
end
