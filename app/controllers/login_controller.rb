class LoginController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by_email params[:email]
    if user and user.password_matches?(params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard/show"
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
