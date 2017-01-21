class PasswordRecoveryController < ApplicationController
  def forgot_password
  end

  def change_password
  end

  def password_recovery
    user = User.find_by(email: recovery_params[:email])
    if user
      user.send_password_reset_token
      render json: { message: change_password_path }, status: 200
    else
      render json: { message: "There is an error occurred." }, status: 422
    end
  end

  def changing_password
    user = User.find_by(email: recovery_params[:email])
    if user
      if user[:reset_password_token] == recovery_params[:token]
        if user.update(password: recovery_params[:new_password])
          render json: { message: login_path }, status: 200
        else
          render json: { message: "There is an error occurred." }, status: 422
        end
      else
        render json: { message: "Your password recovery code is wrong." }, status: 422
      end
    else
      render json: { message: "There is no user with this email." }, status: 422
    end
  end

  private

  def recovery_params
    params.permit(:email, :token, :new_password)
  end
end