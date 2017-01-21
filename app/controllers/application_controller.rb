class ApplicationController < ActionController::Base
  helper_method :current_user, :get_site_setting

  def current_user
    @current_user = session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def authorize
    unless current_user
      render json: { message: "You must login for this action." }, status: 401
    end
  end

  def get_site_setting
    Rails.cache.fetch("site_settings") { SiteSetting.last }
  end

  def model_errors_json(user)
    " #{user.errors.messages.first[0]} #{user.errors.messages.first[1][0].to_s}"
  end
end
