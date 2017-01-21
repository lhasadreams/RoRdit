class SessionsController < ApplicationController
  def index
    render "sessions/login"
  end

  def login
    if User.exists?(email: session_params[:email])
      @user = User.find_by(email: session_params[:email])
      if @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        render json: { message: index_path }, status: 200
      else
        render json: { message: "Your password or email is wrong." }, status: 422
      end
    else
      render json: { message: "There is no user with this email." }, status: 422
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to index_path
  end

  private

  def session_params
    params.permit(:email, :password, :utf8, :authenticity_token)
  end
end
